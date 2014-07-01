package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class InitCompleteEvent extends Event
{

    public static const TYPE : String = "StartSimResetEmitterPropertiesEvent";

    public function InitCompleteEvent()
    {
        super( TYPE );
    }

    override public function clone() : Event
    {
        return new InitCompleteEvent();
    }
}
}
