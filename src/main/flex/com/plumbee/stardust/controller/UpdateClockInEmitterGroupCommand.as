/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 02/01/14
 * Time: 21:54
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{

import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.UpdateClockInEmitterGroupEvent;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class UpdateClockInEmitterGroupCommand implements ICommand
{
    [Inject]
    public var project : ProjectModel;

    [Inject]
    public var event : UpdateClockInEmitterGroupEvent;

    public function execute() : void
    {
        project.emitterInFocus.emitter.clock = event.clock;
    }
}
}
