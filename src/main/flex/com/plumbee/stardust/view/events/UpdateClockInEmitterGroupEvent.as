/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 02/01/14
 * Time: 21:52
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

import idv.cjcat.stardustextended.common.clocks.ImpulseClock;

public class UpdateClockInEmitterGroupEvent extends Event
{
    private var _clock : ImpulseClock;
    public static const UPDATE : String = "UpdateClockInEmitterGroupEvent_UPDATE";

    public function UpdateClockInEmitterGroupEvent( type : String, clock : ImpulseClock )
    {
        super( type );
        _clock = clock;
    }

    override public function clone() : Event
    {
        return new UpdateClockInEmitterGroupEvent( type, _clock );
    }

    public function get clock() : ImpulseClock
    {
        return _clock;
    }
}
}
