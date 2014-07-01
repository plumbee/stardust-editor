/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 14:54
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class EmitterChangeEvent extends Event
{
    public static const ADD : String = "EmitterChangeEvent_ADD";
    public static const REMOVE : String = "EmitterChangeEvent_REMOVE";

    public function EmitterChangeEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new EmitterChangeEvent( type );
    }
}
}
