/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 19:00
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class MainViewSaveSimEvent extends Event
{
    public static const SAVE : String = "MainViewSaveSimEvent_SAVE";

    public function MainViewSaveSimEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new MainViewSaveSimEvent( type );
    }
}
}
