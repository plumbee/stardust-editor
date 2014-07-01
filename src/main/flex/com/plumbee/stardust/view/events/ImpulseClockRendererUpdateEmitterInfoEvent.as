/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 02/01/14
 * Time: 22:19
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{

import flash.events.Event;

public class ImpulseClockRendererUpdateEmitterInfoEvent extends Event
{
    public static const UPDATE : String = "ImpulseClockRendererUpdateEmitterInfoEvent_UPDATE";
    private var _burstInterval : int;
    private var _numParticles : int;
    private var _numBursts : int;


    public function ImpulseClockRendererUpdateEmitterInfoEvent( burstInterval : int, numParticles : int, numBursts : int )
    {
        super( UPDATE );
        _burstInterval = burstInterval;
        _numParticles = numParticles;
        _numBursts = numBursts;
    }

    override public function clone() : Event
    {
        return new ImpulseClockRendererUpdateEmitterInfoEvent( _burstInterval, _numParticles, _numBursts );
    }

    public function get burstInterval() : int
    {
        return _burstInterval;
    }

    public function get numParticles() : int
    {
        return _numParticles;
    }

    public function get numBursts() : int
    {
        return _numBursts;
    }
}
}
