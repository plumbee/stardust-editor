/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 14:41
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class EmitterChangeUIViewEvent extends Event
{
    public static const ADD : String = "EmitterChangeUIViewEvent_ADD";
    public static const REMOVE : String = "EmitterChangeUIViewEvent_REMOVE";

    public function EmitterChangeUIViewEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new EmitterChangeUIViewEvent( type );
    }
}
}
