/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 06/12/13
 * Time: 10:04
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class StartToolEvent extends Event
{
    public static const START_TOOL : String = "StartToolEvent";

    public function StartToolEvent()
    {
        super( START_TOOL );
    }

    override public function clone() : Event
    {
        return new StartToolEvent( );
    }
}
}
