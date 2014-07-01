/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 13/01/14
 * Time: 14:59
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class UpdateClockValuesFromModelEvent extends Event
{
    public static const UPDATE : String = "UpdateClockValuesFromModelEvent_UPDATE";

    public function UpdateClockValuesFromModelEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new UpdateClockValuesFromModelEvent( type );
    }
}
}
