package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.ChangeEmitterInFocusEvent;
import com.plumbee.stardust.controller.events.StartSimEvent;
import com.plumbee.stardust.controller.events.UpdateEmitterDropDownListEvent;
import com.plumbee.stardust.model.ProjectModel;

import flash.events.IEventDispatcher;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class ChangeEmitterInFocusCommand implements ICommand
{

    [Inject]
    public var dispatcher : IEventDispatcher;

    [Inject]
    public var project : ProjectModel;

    [Inject]
    public var event : ChangeEmitterInFocusEvent;

    public function execute() : void
    {
        project.emitterInFocus = event.emitter;

        //refresh the emitter dropdown list.
        dispatcher.dispatchEvent( new UpdateEmitterDropDownListEvent( UpdateEmitterDropDownListEvent.UPDATE ) );

        dispatcher.dispatchEvent( new StartSimEvent() );
    }
}
}
