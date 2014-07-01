package com.plumbee.stardust.controller
{

import avmplus.getQualifiedClassName;

import com.plumbee.stardust.model.ProjectModel;

import flash.display.DisplayObject;

import flash.display.Loader;

import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.net.FileFilter;

import flash.net.FileReference;

import idv.cjcat.stardustextended.common.initializers.Initializer;
import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.initializers.PositionAnimated;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

use namespace sd;

public class LoadEmitterPathCommand implements ICommand
{

    [Inject]
    public var model : ProjectModel;

    private var movieClipLoader : Loader;
    private var currentFrame : uint = 0;
    private var path : Vector.<Point>;
    private var mc : MovieClip;
    private var _loadFile : FileReference;

    public function execute() : void
    {
        _loadFile = new FileReference();
        _loadFile.addEventListener( Event.SELECT, selectHandler );
        _loadFile.browse( [new FileFilter("Emitter Path(*.swf)", "*.swf")] );
    }

    private function selectHandler( event : Event ) : void
    {
        _loadFile.removeEventListener( Event.SELECT, selectHandler );
        _loadFile.addEventListener( Event.COMPLETE, loadCompleteHandler );
        _loadFile.load();
    }

    private function loadCompleteHandler( event : Event ) : void
    {
        _loadFile.removeEventListener( Event.COMPLETE, loadCompleteHandler );
        movieClipLoader = new Loader();
        movieClipLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
        movieClipLoader.loadBytes( _loadFile.data );
    }

    private function onLoadComplete( e : Event ) : void
    {
        movieClipLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
        mc = movieClipLoader.content as MovieClip;
        currentFrame = 0;
        path = new Vector.<Point>();

        mc.addEventListener( Event.FRAME_CONSTRUCTED, onFrameReady );
        mc.gotoAndStop( 0 );
    }

    private function onFrameReady( e : Event ) : void
    {
        // This needs to be calculated in such weird way, because if you call gotoAndStop()
        // Flash sometimes does not create the children. So we have to wait for the next render to do it.
        var emitterFound : Boolean = false;
        for ( var k : int = 0; k < mc.numChildren; k ++ )
        {
            var currChild : DisplayObject = mc.getChildAt( k );
            var className : String = getQualifiedClassName( currChild );
            if ( className == "emitter" )
            {
                path.push( new Point( currChild.x, currChild.y ) );
                emitterFound = true;
            }
        }
        currentFrame ++;
        if ( currentFrame >= mc.totalFrames )
        {
            mc.removeEventListener( Event.FRAME_CONSTRUCTED, onFrameReady );
            for each (var initalizer : Initializer in model.emitterInFocus.emitter.sd::initializers)
            {
                if ( initalizer is PositionAnimated)
                {
                    PositionAnimated(initalizer).positions = path;
                    return;
                }
            }
        }
        mc.gotoAndStop( currentFrame );
    }



}
}
