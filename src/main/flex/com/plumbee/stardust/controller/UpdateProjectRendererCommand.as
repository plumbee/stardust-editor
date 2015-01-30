package com.plumbee.stardust.controller
{
import com.plumbee.stardust.helpers.Globals;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.SimTimeModel;
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.project.DisplayModes;

import flash.events.IEventDispatcher;
import flash.utils.Dictionary;

import idv.cjcat.stardustextended.sd;

import robotlegs.bender.extensions.commandCenter.api.ICommand;


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

}
}
