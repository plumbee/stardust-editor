/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 15:48
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{

import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.OnActionACChangeEvent;

import idv.cjcat.stardustextended.common.actions.Action;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class OnActionACAddCommand implements ICommand
{

    [Inject]
    public var event : OnActionACChangeEvent;

    [Inject]
    public var project : ProjectModel;

    public function execute() : void
    {
        project.emitterInFocus.emitter.addAction( Action( event.action ) );
    }
}
}
