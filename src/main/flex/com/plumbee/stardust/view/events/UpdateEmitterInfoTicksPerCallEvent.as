/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 19/12/13
 * Time: 15:27
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class UpdateEmitterInfoTicksPerCallEvent extends Event
{
    private var _ticksPerCall : Number;
    public static const UPDATE : String = "UpdateEmitterInfoTicksPerCallEvent_UPDATE";

    public function UpdateEmitterInfoTicksPerCallEvent( type : String, ticksPerCall : Number )
    {
        super( type );
        this._ticksPerCall = ticksPerCall;
    }

    override public function clone() : Event
    {
        return new UpdateEmitterInfoTicksPerCallEvent( type, _ticksPerCall );
    }

    public function get ticksPerCall() : Number
    {
        return _ticksPerCall;
    }
}
}
