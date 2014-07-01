/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 13/01/14
 * Time: 15:28
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

import idv.cjcat.stardustextended.common.clocks.ImpulseClock;

public class UpdateImpulseClockRendererEvent extends Event
{
    public static const UPDATE : String = "UpdateImpulseClockRendererEvent_UPDATE";
    private var _clock : ImpulseClock;

    public function UpdateImpulseClockRendererEvent( type : String, impulseClock : ImpulseClock )
    {
        super( type );
        _clock = impulseClock;
    }

    override public function clone() : Event
    {
        return new UpdateImpulseClockRendererEvent( type, _clock );
    }

    public function get clock() : ImpulseClock
    {
        return _clock;
    }
}
}
