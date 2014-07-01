/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 16:47
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{

import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.OnActionACChangeEvent;

import idv.cjcat.stardustextended.common.actions.Action;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class OnActionACRemoveCommand implements ICommand
{

    [Inject]
    public var project : ProjectModel;

    [Inject]
    public var event : OnActionACChangeEvent;

    public function execute() : void
    {
        project.emitterInFocus.emitter.removeAction( Action( event.action ) );
    }
}
}
