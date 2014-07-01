/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 14/02/14
 * Time: 13:52
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{
import com.plumbee.stardust.controller.events.StartSimEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.UpdateSmoothingEvent;
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import flash.events.IEventDispatcher;

import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.initializers.BitmapParticleInit;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

use namespace sd;

public class UpdateSmoothingCommand implements ICommand
{
    [Inject]
    public var event : UpdateSmoothingEvent;

    [Inject]
    public var dispatcher : IEventDispatcher;

    [Inject]
    public var projectSettings : ProjectModel;

    public function execute() : void
    {
        const emitterVO : EmitterValueObject = projectSettings.emitterInFocus;

        const inits : Array = emitterVO.emitter.sd::initializers;
        const numInits : uint = inits.length;
        for (var i:uint=0; i < numInits; i++)
        {
            var bitmapInit : BitmapParticleInit = inits[i] as BitmapParticleInit;
            if ( bitmapInit )
            {
                bitmapInit.smoothing = event.useSmoothing;
                break;
            }
        }

        dispatcher.dispatchEvent( new StartSimEvent() );
    }
}
}
