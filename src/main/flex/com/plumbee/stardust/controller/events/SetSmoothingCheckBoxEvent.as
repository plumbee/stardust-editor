/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 14/02/14
 * Time: 14:39
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import com.plumbee.stardust.view.events.UpdateSmoothingEvent;

import flash.events.Event;

public class SetSmoothingCheckBoxEvent extends Event
{
    public static const SET : String = "SetSmoothingCheckBoxEvent_SET";
    private var _smoothing : Boolean;

    public function SetSmoothingCheckBoxEvent( smoothing : Boolean )
    {
        super( SET );
        _smoothing = smoothing;
    }

    override public function clone() : Event
    {
        return new UpdateSmoothingEvent( _smoothing );
    }

    public function get smoothing() : Boolean
    {
        return _smoothing;
    }
}
}
