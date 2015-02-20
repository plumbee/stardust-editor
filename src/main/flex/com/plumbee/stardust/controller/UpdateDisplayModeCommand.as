package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.SetBlendModeSelectedEvent;
import com.plumbee.stardust.controller.events.UpdateDisplayModeEvent;
import com.plumbee.stardust.controller.events.UpdateProjectRendererEvent;
import com.plumbee.stardust.helpers.Globals;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
import com.plumbee.stardustplayer.project.DisplayModes;

import flash.display.BlendMode;
import flash.events.IEventDispatcher;
import flash.utils.Dictionary;

import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.handlers.BlendModeHandler;
import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;

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

		dispatcher.dispatchEvent(new UpdateProjectRendererEvent(UpdateProjectRendererEvent.UPDATE));
	}

	private function setDisplayModeStarling() : void
	{
		projectSettings.setDisplayMode(DisplayModes.STARLING);

		var blendModeHandler : BlendModeHandler = projectSettings.emitterInFocus.emitter.particleHandler as BlendModeHandler;
		if(blendModeHandler != null)
		{
			dispatcher.dispatchEvent(new SetBlendModeSelectedEvent(SetBlendModeSelectedEvent.STARLING, blendModeHandler.blendMode));
		}
	}

	private function setDisplayModeDisplayList() : void
	{
		projectSettings.setDisplayMode(DisplayModes.DISPLAY_LIST);

		var blendModeHandler : BlendModeHandler = projectSettings.emitterInFocus.emitter.particleHandler as BlendModeHandler;
		if(blendModeHandler != null)
		{
			dispatcher.dispatchEvent(new SetBlendModeSelectedEvent(SetBlendModeSelectedEvent.DISPLAY_LIST, blendModeHandler.blendMode));
		}
	}
}
}
