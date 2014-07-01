/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 13/01/14
 * Time: 15:21
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

import idv.cjcat.stardustextended.common.clocks.SteadyClock;

public class UpdateSteadyClockRendererEvent extends Event
{
    public static const UPDATE : String = "UpdateSteadyClockRendererEvent_UPDATE";
    private var _clock : SteadyClock;
    private var _ticksPerCall : Number;

    public function UpdateSteadyClockRendererEvent( type : String, clock : SteadyClock, ticksPerCall : Number )
    {
        super( type );
        _clock = clock;
        _ticksPerCall = ticksPerCall;
    }

    override public function clone() : Event
    {
        return new UpdateSteadyClockRendererEvent( type, _clock, _ticksPerCall );
    }

    public function get clock() : SteadyClock
    {
        return _clock;
    }

    public function get ticksPerCall() : Number
    {
        return _ticksPerCall;
    }
}
}
