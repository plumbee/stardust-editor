/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 02/01/14
 * Time: 21:20
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class ImpulseClockRendererSetDataEvent extends Event
{
    public static const SET : String = "ImpulseClockRendererSetDataEvent_SET";

    public function ImpulseClockRendererSetDataEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new ImpulseClockRendererSetDataEvent( type );
    }
}
}
