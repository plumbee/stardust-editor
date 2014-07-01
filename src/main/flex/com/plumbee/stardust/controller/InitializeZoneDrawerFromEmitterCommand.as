/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 15/01/14
 * Time: 17:56
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{
import com.plumbee.stardust.helpers.ZoneDrawer;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.InitializeZoneDrawerFromEmitterGroupEvent;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class InitializeZoneDrawerFromEmitterCommand implements ICommand
{

    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var event : InitializeZoneDrawerFromEmitterGroupEvent;

    public function execute() : void
    {
        // TODO support all emitters
        ZoneDrawer.init( projectSettings.emitterInFocus.emitter, event.targetGraphics );
    }
}
}
