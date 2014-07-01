/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 02/01/14
 * Time: 20:32
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class UpdateBlendModeEvent extends Event
{
    public static const UPDATE : String = "UpdateBlendModeEvent_UPDATE";
    private var _newBlendMode : String;

    public function UpdateBlendModeEvent( type : String, newBlendMode : String )
    {
        super( type );
        _newBlendMode = newBlendMode;
    }

    override public function clone() : Event
    {
        return new UpdateBlendModeEvent( type, _newBlendMode );
    }

    public function get newBlendMode() : String
    {
        return _newBlendMode;
    }
}
}
