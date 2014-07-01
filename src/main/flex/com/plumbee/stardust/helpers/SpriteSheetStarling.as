package com.plumbee.stardust.helpers
{
import com.plumbee.stardust.helpers.starling.TextureManager;

import flash.display.BitmapData;
import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class SpriteSheetStarling extends Sprite
{
    private static const LOG : ILogger = Log.getLogger( getQualifiedClassName( SpriteSheetStarling ).replace( "::", "." ) );

    private var currImage : uint = 0;
    private var currFrame : uint = 0;
    private var image : Image;
    private var animSpeed : int;
    private var textureCache : SpriteSheetTextureCache;

    public function SpriteSheetStarling( imgWidth : int, imgHeight : int, animSpeed : uint,
                                         startAtRandomFrame : Boolean, emitterIndex : int, bitmapData : BitmapData )
    {
        if ( animSpeed == 0 )
        {
            animSpeed = 1;
        }
        this.animSpeed = animSpeed;

        var textureManager : TextureManager = Globals.textureManager;
        textureCache = textureManager.addSpriteSheet( bitmapData, imgWidth, imgHeight, emitterIndex );

        if ( startAtRandomFrame )
        {
            currImage = Math.random() * textureCache.textures.length;
        }
        image = new Image( textureCache.textures[0] );
        addChild( image );

        addEventListener( Event.ADDED_TO_STAGE, addEnterFrameListener );
    }

    private function addEnterFrameListener( e : Event ) : void
    {
        removeEventListener( Event.ADDED_TO_STAGE, addEnterFrameListener );
        addEventListener( Event.ENTER_FRAME, onEnterFrame );
        addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
        addEventListener( Event.REMOVE_FROM_JUGGLER, onRemovedFromJuggler );
    }

    private function onEnterFrame( event : Event ) : void
    {
        if ( currFrame == animSpeed )
        {
            image.texture = textureCache.textures[currImage];
            currImage ++;
            if ( currImage == textureCache.textures.length )
            {
                currImage = 0;
            }
            currFrame = 0;
        }
        currFrame ++;
    }

    private function onRemovedFromJuggler( event : Event ) : void
    {
        LOG.info( "Sprite Sheet removed from Juggler." );
        onRemoved( event );
    }

    private function onRemoved( event : Event ) : void
    {
        currImage = 0;
        currFrame = animSpeed;
        removeEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
        removeEventListener( Event.ENTER_FRAME, onEnterFrame );
        removeEventListener( Event.REMOVE_FROM_JUGGLER, onRemovedFromJuggler );

        addEventListener( Event.ADDED_TO_STAGE, addEnterFrameListener );
    }


}
}
