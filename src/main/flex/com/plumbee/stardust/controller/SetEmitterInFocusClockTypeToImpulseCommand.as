/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 14/01/14
 * Time: 10:44
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{

import com.plumbee.stardust.model.ProjectModel;

import flash.utils.getQualifiedClassName;

import idv.cjcat.stardustextended.common.clocks.ImpulseClock;

import mx.logging.ILogger;
import mx.logging.Log;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class SetEmitterInFocusClockTypeToImpulseCommand implements ICommand
{
    [Inject]
    public var project : ProjectModel;

    private static const LOG : ILogger = Log.getLogger( getQualifiedClassName( SetEmitterInFocusClockTypeToImpulseCommand ).replace( "::", "." ) );

    public function execute() : void
    {
        LOG.info( "Set Emitter in focus clock to new Impulse Clock." );

        //Set default, changed later
        project.emitterInFocus.emitter.clock = new ImpulseClock( 1, 1 );
    }
}
}
