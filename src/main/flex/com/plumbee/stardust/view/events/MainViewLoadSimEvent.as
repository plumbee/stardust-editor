/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 18:58
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class MainViewLoadSimEvent extends Event
{
    public static const LOAD : String = "MainViewLoadSimEvent_LOAD";

    public function MainViewLoadSimEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new MainViewLoadSimEvent( type );
    }
}
}
