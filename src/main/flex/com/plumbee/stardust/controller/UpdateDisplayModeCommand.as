package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.SetBlendModeSelectedEvent;
import com.plumbee.stardust.controller.events.UpdateDisplayModeEvent;
import com.plumbee.stardust.controller.events.UpdateProjectRendererEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.project.DisplayModes;

import flash.events.IEventDispatcher;

import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.handlers.BlendModeParticleHandler;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

use namespace sd;

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
		setDisplayMode(event.mode);

		dispatcher.dispatchEvent(new UpdateProjectRendererEvent(UpdateProjectRendererEvent.UPDATE));
	}

	private function setDisplayMode(displayMode : String) : void
	{
		var eventString : String;
		switch (displayMode)
		{
			case DisplayModes.STARLING :
				eventString = SetBlendModeSelectedEvent.STARLING;
				break;
			case DisplayModes.DISPLAY_LIST :
				eventString = SetBlendModeSelectedEvent.DISPLAY_LIST;
				break;
			default :
				return;
		}

		projectSettings.setDisplayMode(displayMode);

		var blendModeHandler : BlendModeParticleHandler = projectSettings.emitterInFocus.emitter.particleHandler as BlendModeParticleHandler;
		if(blendModeHandler != null)
		{
			dispatcher.dispatchEvent(new SetBlendModeSelectedEvent(eventString, blendModeHandler.blendMode));
		}
	}
}
}
