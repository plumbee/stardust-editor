package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.StartSimEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.UpdateBlendModeEvent;
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;

import flash.events.IEventDispatcher;

import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
import idv.cjcat.stardustextended.twoD.handlers.BlendModeParticleHandler;

import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class UpdateBlendModeCommand implements ICommand
{
    [Inject]
    public var dispatcher : IEventDispatcher;

    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var event : UpdateBlendModeEvent;

    public function execute() : void
    {
        var emitterVO : BaseEmitterValueObject = projectSettings.emitterInFocus;

        var handler : ParticleHandler = emitterVO.emitter.particleHandler;

	    if(handler is DisplayObjectHandler)
	    {
		    DisplayObjectHandler(handler).blendMode = event.newBlendMode;
	    }
	    else if(handler is BlendModeParticleHandler)
	    {
		    BlendModeParticleHandler(handler).blendMode = event.newBlendMode;
	    }

        dispatcher.dispatchEvent( new StartSimEvent() );
    }
}
}
