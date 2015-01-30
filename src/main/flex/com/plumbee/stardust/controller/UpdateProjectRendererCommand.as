package com.plumbee.stardust.controller
{
import com.plumbee.stardust.helpers.Globals;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.SimTimeModel;
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
import com.plumbee.stardustplayer.emitter.DisplayListEmitterValueObject;
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.emitter.StarlingEmitterValueObject;
import com.plumbee.stardustplayer.project.DisplayModes;

import flash.events.IEventDispatcher;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;
import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
import idv.cjcat.stardustextended.twoD.initializers.BitmapParticleInit;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

import starling.textures.Texture;

use namespace sd;

public class UpdateProjectRendererCommand implements ICommand
{
	[Inject]
	public var dispatcher : IEventDispatcher;

	[Inject]
	public var simPlayer : SimPlayer;

	[Inject]
	public var simTimeModel : SimTimeModel;

	[Inject]
	public var projectSettings : ProjectModel;

	public function execute() : void
	{
		simTimeModel.resetTime();

		for each(var emitterVO : IBaseEmitter in getEmitters())
		{
			emitterVO.resetEmitter();
			getEmitterRenderingSetup().prepareEmitter(emitterVO,getRenderCanvas());
		}
	}

	protected function getRenderCanvas() : *
	{
		switch (projectSettings.getDisplayMode())
		{
			case DisplayModes.STARLING:
				return Globals.starlingCanvas;
			case DisplayModes.DISPLAY_LIST:
				return Globals.canvas;
		}
		return null;
	}

	protected function getEmitters() : Dictionary
	{
		return projectSettings.stadustSim.emitters;
	}

	private function getEmitterRenderingSetup() : IEmitterRenderingSetup
	{
		switch (projectSettings.getDisplayMode())
		{
			case DisplayModes.STARLING:
				return getStarlingDelegate();
			case DisplayModes.DISPLAY_LIST:
				return getDisplayListDelegate();
		}
		return null;
	}

	protected function getDisplayListDelegate() : IEmitterRenderingSetup
	{
		return new EmitterRenderingSetupDisplayList();
	}

	protected function getStarlingDelegate() : IEmitterRenderingSetup
	{
		return new EmitterRenderingSetupStarling();
	}

	protected function setupRenderingForStarling(emitterVO : BaseEmitterValueObject) : void
	{
		var starlingEmitterValueObject : StarlingEmitterValueObject = new StarlingEmitterValueObject(emitterVO.id, emitterVO.emitter);
		starlingEmitterValueObject.addStarlingInitializers(getTexturesFromBitmapParticleInit(emitterVO.emitter));
		(starlingEmitterValueObject.emitter.particleHandler as StarlingHandler).container = Globals.starlingCanvas;
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
