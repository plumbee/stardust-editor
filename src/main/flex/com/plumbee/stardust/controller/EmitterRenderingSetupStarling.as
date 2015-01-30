package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.emitter.IStarlingEmitter;

import flash.geom.Rectangle;

import idv.cjcat.stardustextended.sd;

import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
import idv.cjcat.stardustextended.twoD.initializers.BitmapParticleInit;

import starling.display.DisplayObjectContainer;
import starling.textures.Texture;

public class EmitterRenderingSetupStarling extends EmitterRenderingSetupBase
{
	public function EmitterRenderingSetupStarling()
	{
		emitterType = IStarlingEmitter;
		canvasType = DisplayObjectContainer;
	}

	override protected function doPrepareEmitterTemplate(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		var e : IStarlingEmitter = emitter as IStarlingEmitter;
		e.addStarlingInitializers(null);
		e.updateHandlerCanvas(targetRenderCanvas);
	}

	private function getTexturesFromBitmapParticleInit(emitter2D : Emitter2D) : Vector.<Texture>
	{
		const initializers : Array = emitter2D.sd::initializers;

		for (var i : int = 0; i < initializers.length; i++)
		{
			var bitmapParticleInit : BitmapParticleInit = initializers[i] as BitmapParticleInit;
			if (bitmapParticleInit)
			{

				var textures : Vector.<Texture> = new Vector.<Texture>();
				var mainTexture : Texture = Texture.fromBitmapData(bitmapParticleInit.bitmapData);

				if (bitmapParticleInit.bitmapType == BitmapParticleInit.SINGLE_IMAGE)
				{
					textures.push(mainTexture);
				}
				else
				{
					var numTextures : uint = mainTexture.width / bitmapParticleInit.spriteSheetSliceWidth;

					for (var j : uint = 0; j < numTextures; j++)
					{
						var frame : Rectangle = new Rectangle(j * bitmapParticleInit.spriteSheetSliceWidth, 0, bitmapParticleInit.spriteSheetSliceWidth, bitmapParticleInit.spriteSheetSliceHeight);
						textures.push(Texture.fromTexture(mainTexture, frame));
					}
				}

				return textures;
			}
		}

		return null;
	}
}
}
