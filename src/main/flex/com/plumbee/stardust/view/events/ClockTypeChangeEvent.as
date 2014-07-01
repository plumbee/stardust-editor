/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 14/01/14
 * Time: 10:31
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class ClockTypeChangeEvent extends Event
{
    public static const STEADY_CLOCK : String = "ClockTypeChangeEvent_STEADY_CLOCK";
    public static const IMPULSE_CLOCK : String = "ClockTypeChangeEvent_IMPULSE_CLOCK";

    public function ClockTypeChangeEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new ClockTypeChangeEvent( type );
    }
}
}
