/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 20/12/13
 * Time: 16:28
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class UpdateDisplayModeEvent extends Event
{
    public static const UPDATE : String = "UpdateDisplayModeEvent_UPDATE";

    private var _mode : String;

    public function UpdateDisplayModeEvent( type : String, mode : String )
    {
        super( type );
        _mode = mode;
    }

    override public function clone() : Event
    {
        return new UpdateDisplayModeEvent( type, _mode );
    }

    public function get mode() : String
    {
        return _mode;
    }
}
}
