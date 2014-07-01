/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 16:50
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{

import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.OnInitializerACChangeEvent;

import idv.cjcat.stardustextended.common.initializers.Initializer;


import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class OnInitializerACRemoveCommand implements ICommand
{
    [Inject]
    public var project : ProjectModel;

    [Inject]
    public var event : OnInitializerACChangeEvent;

    public function execute() : void
    {

        //LOG.debug( "Initializer Removed: " + e.items[0] );
        project.emitterInFocus.emitter.removeInitializer( Initializer( event.initializer ) );
    }
}
}
