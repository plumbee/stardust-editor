package com.plumbee.stardust.controller.events
{

import flash.events.Event;
import flash.events.IEventDispatcher;

public class BackgroundChangeEvent extends Event
{
    public static const COLOR : String = "color";
    public static const IMAGE : String = "image";
    public static const HAS_BACKGROUND : String = "hasBackground";

    public static const TYPE : String = "BackgroundChangeEvent_Type";
    private var _value : Object;
    private var _property : String;

    public function BackgroundChangeEvent(property : String, value : Object)
    {
        super(TYPE);
        _property = property;
        _value = value;
    }

    public function get value() : Object
    {
        return _value;
    }

    public function get property() : String
    {
        return _property;
    }

    override public function clone() : Event
    {
        return new BackgroundChangeEvent(_property, _value);
    }

}
}