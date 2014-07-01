/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 13/01/14
 * Time: 17:34
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class ResetClockTimersEvent extends Event
{
    public static const RESET : String = "ResetClockTimersEvent_RESET";

    public function ResetClockTimersEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new ResetClockTimersEvent( type );
    }
}
}
