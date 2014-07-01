/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 02/01/14
 * Time: 22:22
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller
{
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.ImpulseClockRendererUpdateEmitterInfoEvent;
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import idv.cjcat.stardustextended.common.clocks.ImpulseClock;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class ImpulseClockRendererUpdateEmitterInfoCommand implements ICommand
{
    [Inject]
    public var projectSetting : ProjectModel;

    [Inject]
    public var event : ImpulseClockRendererUpdateEmitterInfoEvent;

    public function execute() : void
    {
        var info : EmitterValueObject = projectSetting.emitterInFocus;
        info.burstClockInterval = event.burstInterval;

        ImpulseClock(info.emitter.clock).impulseCount = event.numParticles;
        ImpulseClock(info.emitter.clock).repeatCount = event.numBursts;
    }
}
}
