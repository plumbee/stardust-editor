package com.plumbee.stardust.helpers
{

import flash.display.BitmapData;

import idv.cjcat.stardustextended.twoD.display.bitmapParticle.IBitmapParticle;

import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class CenteredStarling extends Sprite implements IBitmapParticle
{

    public function initWithSingleBitmap( bitmapData : BitmapData, _smoothing : Boolean ) : void
    {
        // TODO: this is very likely not optimal
        removeChildren();
        //If context is lost, will cause error trying to upload texture.
        // TODO dont ask for emitter index here
        var particleTexture : Texture = Globals.textureManager.addSingleTexture( bitmapData, 0 );
        var image : Image = new Image(particleTexture);
        addChild(image);
    }

    public function initWithSpriteSheet( imgWidth : int, imgHeight : int, _animSpeed : uint, startAtRandomFrame : Boolean, bitmapData : BitmapData, _smoothing : Boolean ) : void
    {
        // TODO
    }

    public function stepSpriteSheet(stepTime : uint) : void
    {
        //todo
    }
}
}
