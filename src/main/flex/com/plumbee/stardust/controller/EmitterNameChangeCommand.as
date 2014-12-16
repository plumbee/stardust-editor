package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.UpdateEmitterDropDownListEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.EmitterNameChangeEvent;
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;

import flash.events.IEventDispatcher;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class EmitterNameChangeCommand implements ICommand
{
    [Inject]
    public var event : EmitterNameChangeEvent;

    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var dispatcher : IEventDispatcher;

    public function execute() : void
    {
        var name : String = event.name;
        var emitterVO : BaseEmitterValueObject = event.emitterVO;
        emitterVO.emitter.name = name;

        dispatcher.dispatchEvent( new UpdateEmitterDropDownListEvent( UpdateEmitterDropDownListEvent.UPDATE ) );

    }
}
}
