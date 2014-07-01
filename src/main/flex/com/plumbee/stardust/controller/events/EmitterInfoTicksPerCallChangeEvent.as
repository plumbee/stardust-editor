/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 19/12/13
 * Time: 17:51
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class EmitterInfoTicksPerCallChangeEvent extends Event
{
    public static const CHANGE : String = "EmitterInfoTicksPerCallChangeEvent_CHANGE";
    private var _ticksPerCall : Number;

    public function EmitterInfoTicksPerCallChangeEvent( type : String, ticksPerCall : Number )
    {
        super( type );

        _ticksPerCall = ticksPerCall;
    }

    override public function clone() : Event
    {
        return new EmitterInfoTicksPerCallChangeEvent( type, _ticksPerCall );
    }

    public function get ticksPerCall() : Number
    {
        return _ticksPerCall;
    }
}
}
