package com.plumbee.stardust.controller.events
{

import flash.events.Event;

public class SetDisplayModeEvent extends Event
{
    public static const DISPLAY_LIST : String = "SetDisplayModeEvent_DISPLAY_LIST";
    public static const STARLING : String = "SetDisplayModeEvent_STARLING";
    public static const SET_DISPLAY_MODE : String = "SetDisplayModeEvent_TYPE";
    private var _displayMode : String;

    public function SetDisplayModeEvent( displayMode : String)
    {

        super( SET_DISPLAY_MODE );
        _displayMode = displayMode;
    }

    override public function clone() : Event
    {
        return new SetDisplayModeEvent(_displayMode);
    }

    public function get displayMode() : String
    {
        return _displayMode;
    }
}
}
