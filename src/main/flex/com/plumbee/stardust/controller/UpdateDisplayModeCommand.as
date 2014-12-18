package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.SetBlendModeSelectedEvent;
import com.plumbee.stardust.controller.events.UpdateDisplayModeEvent;
import com.plumbee.stardust.helpers.Globals;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
import com.plumbee.stardustplayer.emitter.StarlingEmitterValueObject;
import com.plumbee.stardustplayer.project.DisplayModes;

import flash.display.BlendMode;
import flash.events.IEventDispatcher;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
import idv.cjcat.stardustextended.twoD.initializers.BitmapParticleInit;
import idv.cjcat.stardustextended.twoD.initializers.PooledDisplayObjectClass;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

import starling.textures.Texture;

use namespace sd;

// not used now
public class UpdateDisplayModeCommand implements ICommand
{
	[Inject]
	public var event : UpdateDisplayModeEvent;

	[Inject]
	public var dispatcher : IEventDispatcher;

	[Inject]
	public var projectSettings : ProjectModel;

	public function execute() : void
	{
		var mode : String = event.mode;
		switch (mode)
		{
			case DisplayModes.DISPLAY_LIST :
				setDisplayModeDisplayList();
				break;
			case DisplayModes.STARLING :
				setDisplayModeStarling();
				break;
			default :
				break;
		}
	}

	private function setDisplayModeStarling() : void
	{
		const emitters : Dictionary = projectSettings.stadustSim.emitters;

		for each(var emitterVO : BaseEmitterValueObject in emitters)
		{
			emitterVO.emitter.clearParticles();

			var starlingEmitterValueObject : StarlingEmitterValueObject = new StarlingEmitterValueObject(emitterVO.id, emitterVO.emitter);
			emitterVO = starlingEmitterValueObject;

			var blendMode : String = DisplayObjectHandler(emitterVO.emitter.particleHandler).blendMode;
			if (!isBlendModeStarlingSafe(blendMode))
			{
				DisplayObjectHandler(emitterVO.emitter.particleHandler).blendMode = BlendMode.NORMAL;
			}

			StarlingEmitterValueObject(emitterVO).addStarlingInitializers(getTexturesFromBitmapParticleInit(emitterVO.emitter));

			emitterVO.removeRenderingDependencies();
			(emitterVO.emitter.particleHandler as StarlingHandler).container = Globals.starlingCanvas;
		}

		projectSettings.setDisplayMode(DisplayModes.STARLING);

		const currentBlendMode : String = StarlingHandler(projectSettings.emitterInFocus.emitter.particleHandler).blendMode;
		dispatcher.dispatchEvent(new SetBlendModeSelectedEvent(SetBlendModeSelectedEvent.STARLING, currentBlendMode));
	}

	private function setDisplayModeDisplayList() : void
	{
		projectSettings.setDisplayMode(DisplayModes.DISPLAY_LIST);
		// TODO store BlendMode in a model when switching so its remembered
		dispatcher.dispatchEvent(new SetBlendModeSelectedEvent(SetBlendModeSelectedEvent.DISPLAY_LIST, BlendMode.NORMAL));
	}

	private function isBlendModeStarlingSafe(targetBlendMode : String) : Boolean
	{
		var starlingBlendModes : Array = Globals.blendModesStarling.source;
		var numBlendModes : int = starlingBlendModes.length;
		for (var i : int = 0; i < numBlendModes; i++)
		{
			if (starlingBlendModes[i] == targetBlendMode)
			{
				return true;
			}
		}
		return false;
	}

	private function removeDependencies(emitter2D : Emitter2D) : void
	{
		const initializers : Array = emitter2D.sd::initializers;

		for (var i : int = 0; i < initializers.length; i++)
		{

			if (initializers[i] is PooledDisplayObjectClass || initializers[i] is BitmapParticleInit)
			{
				emitter2D.removeInitializer(initializers[i]);
				i = i - 1;
			}
		}
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
					//Need to get information
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
