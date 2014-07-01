/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 19:32
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class SaveSimEvent extends Event
{
    public static const SAVE : String = "SaveSimEvent_SAVE";

    public function SaveSimEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new SaveSimEvent( type );
    }
}
}
