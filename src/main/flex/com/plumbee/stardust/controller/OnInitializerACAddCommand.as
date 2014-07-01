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
import com.plumbee.stardust.view.events.OnInitializerACChangeEvent;

import idv.cjcat.stardustextended.common.initializers.Initializer;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class OnInitializerACAddCommand implements ICommand
{
    [Inject]
    public var project : ProjectModel;

    [Inject]
    public var event : OnInitializerACChangeEvent;

    public function execute() : void
    {
        //LOG.debug( "Initializer Added: " + e.items[0] );
        project.emitterInFocus.emitter.addInitializer( Initializer( event.initializer ) );
    }
}
}
