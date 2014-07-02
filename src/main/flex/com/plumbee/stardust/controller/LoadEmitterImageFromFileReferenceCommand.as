package com.plumbee.stardust.controller
{
import com.plumbee.stardust.controller.events.RefreshBitmapParticleInitializerRendererEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.emitter.EmitterValueObject;
import com.plumbee.stardustplayer.sequenceLoader.ISequenceLoader;
import com.plumbee.stardustplayer.sequenceLoader.LoadByteArrayJob;

import flash.display.Bitmap;

import flash.events.Event;
import flash.events.IEventDispatcher;

import flash.net.FileFilter;
import flash.net.FileReference;

import idv.cjcat.stardustextended.sd;

import idv.cjcat.stardustextended.twoD.initializers.BitmapParticleInit;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

use namespace sd;

public class LoadEmitterImageFromFileReferenceCommand implements ICommand
{
    [Inject]
    public var sequenceLoader : ISequenceLoader;

    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var dispatcher : IEventDispatcher;

    private var _emitterFileReference : FileReference;

    public function execute() : void
    {
        var loadFile : FileReference = new FileReference();
        var fileFilter : FileFilter = new FileFilter( "Images", ".gif;*.jpeg;*.jpg;*.png" );
        loadFile.browse( [fileFilter] );

        _emitterFileReference = loadFile;
        _emitterFileReference.addEventListener( Event.SELECT, emitterSelectHandler );
    }

    private function emitterSelectHandler( event : Event ) : void
    {
        _emitterFileReference.removeEventListener( Event.SELECT, emitterSelectHandler );
        _emitterFileReference.addEventListener( Event.COMPLETE, loadEmitterFromByteArray );
        _emitterFileReference.load();
    }

    private function loadEmitterFromByteArray( event : Event ) : void
    {
        var emitterName : String = projectSettings.emitterInFocus.id.toString();
        sequenceLoader.removeCompletedJobByName( emitterName );
        var job : LoadByteArrayJob = new LoadByteArrayJob( emitterName, _emitterFileReference.name, _emitterFileReference.data );
        sequenceLoader.addJob( job );
        sequenceLoader.addEventListener( Event.COMPLETE, onEmitterImageLoaded );
        sequenceLoader.loadSequence();
    }

    private function onEmitterImageLoaded( event : Event ) : void
    {
        sequenceLoader.removeEventListener( Event.COMPLETE, onEmitterImageLoaded );

        const emitterVO : EmitterValueObject = projectSettings.emitterInFocus;

        const initializers : Array = emitterVO.emitter.sd::initializers;
        for (var i:int = 0; i < initializers.length; i++)
        {
            var bitmapParticleInit : BitmapParticleInit = initializers[i] as BitmapParticleInit;
            if ( bitmapParticleInit )
            {
                const loadJob : LoadByteArrayJob = sequenceLoader.getJobByName( emitterVO.id.toString() );
                bitmapParticleInit.bitmapData = ( loadJob.content as Bitmap ).bitmapData;
                emitterVO.image = bitmapParticleInit.bitmapData;
                emitterVO.emitter.name = loadJob.fileName;
            }
        }
        dispatcher.dispatchEvent( new RefreshBitmapParticleInitializerRendererEvent() );
    }

}
}
