/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 16:28
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{
import com.plumbee.stardust.controller.events.SetResultsForEmitterDropDownListEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import flash.events.IEventDispatcher;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class UpdateEmitterDropDownListCommand implements ICommand
{

    [Inject]
    public var dispatcher : IEventDispatcher;

    [Inject]
    public var project : ProjectModel;

    public function execute() : void
    {
        var list : Array = [];
        for each (var emitterVO : EmitterValueObject in project.stadustSim.emitters)
        {
            list.push( emitterVO );
        }
        dispatcher.dispatchEvent( new SetResultsForEmitterDropDownListEvent( SetResultsForEmitterDropDownListEvent.UPDATE, list, project.emitterInFocus ) );
    }
}
}
