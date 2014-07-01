/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 14/01/14
 * Time: 10:45
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{

import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.ClockTypeChangeEvent;
import flash.events.IEventDispatcher;
import idv.cjcat.stardustextended.common.clocks.SteadyClock;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class SetEmitterInFocusClockTypeToSteadyCommand implements ICommand
{
    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var event : ClockTypeChangeEvent;

    [Inject]
    public var dispatcher : IEventDispatcher;

    public function execute() : void
    {

        //Set default, changed later
        projectSettings.emitterInFocus.emitter.clock = new SteadyClock( 1 );
    }
}
}
