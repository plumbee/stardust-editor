/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 15:12
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.ChangeEmitterInFocusEvent;
import com.plumbee.stardust.controller.events.StartSimEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
import com.plumbee.stardustplayer.project.ProjectValueObject;

import flash.events.IEventDispatcher;
import flash.utils.getQualifiedClassName;

import mx.logging.ILogger;
import mx.logging.Log;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class RemoveEmitterCommand implements ICommand
{

    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var dispatcher : IEventDispatcher;

    private static const LOG : ILogger = Log.getLogger( getQualifiedClassName( RemoveEmitterCommand ).replace( "::", "." ) );

    public function execute() : void
    {
        const projectObj : ProjectValueObject = projectSettings.stadustSim;
        if (projectObj.numberOfEmitters > 1)
        {
            projectSettings.emitterInFocus.emitter.clearParticles();
            delete projectObj.emitters[projectSettings.emitterInFocus.id];

            for each (var emitter : BaseEmitterValueObject in projectObj.emitters)
            {
                dispatcher.dispatchEvent( new ChangeEmitterInFocusEvent( ChangeEmitterInFocusEvent.CHANGE, emitter ) );
                break;
            }
            dispatcher.dispatchEvent( new StartSimEvent() );
        }
        else
        {
            LOG.warn( "Emitter not removed, must be at least one." );
        }
    }
}
}
