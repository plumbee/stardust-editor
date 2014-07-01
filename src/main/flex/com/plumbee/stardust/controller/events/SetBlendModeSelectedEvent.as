/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 07/01/14
 * Time: 15:30
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class SetBlendModeSelectedEvent extends Event
{
    public static const DISPLAY_LIST : String = "SetBlendModesInDropdownEvent_DISPLAY_LIST";
    public static const STARLING : String = "SetBlendModeSelectedEvent_STARLING";

    private var _targetBlendMode : String;

    public function SetBlendModeSelectedEvent( type : String, targetBlendMode : String )
    {
        super( type );
        _targetBlendMode = targetBlendMode;
    }

    override public function clone() : Event
    {
        return new SetBlendModeSelectedEvent( type, _targetBlendMode );
    }

    public function get targetBlendMode() : String
    {
        return _targetBlendMode;
    }
}
}
