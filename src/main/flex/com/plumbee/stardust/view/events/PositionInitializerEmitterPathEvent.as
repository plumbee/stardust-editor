/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 06/01/14
 * Time: 11:19
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class PositionInitializerEmitterPathEvent extends Event
{
    public static const LOAD : String = "PositionInitializerEmitterPathEvent_LOAD";


    public function PositionInitializerEmitterPathEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new PositionInitializerEmitterPathEvent( type );
    }
}
}
