/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 20/12/13
 * Time: 15:47
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class DisplayModeChangeEvent extends Event
{
    public static const CHANGE : String = "DisplayModeChangeEvent_CHANGE";
    private var _mode : String;

    public function DisplayModeChangeEvent( type : String, mode : String )
    {
        super( type );
        _mode = mode;
    }

    override public function clone() : Event
    {
        return new DisplayModeChangeEvent( type, _mode );
    }

    public function get mode() : String
    {
        return _mode;
    }
}
}
