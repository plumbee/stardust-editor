/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 18/12/13
 * Time: 16:59
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class StartSimEvent extends Event
{
    public static const START : String = "StartSimEvent_START";

    public function StartSimEvent()
    {
        super( START );
    }

    override public function clone() : Event
    {
        return new StartSimEvent();
    }
}
}
