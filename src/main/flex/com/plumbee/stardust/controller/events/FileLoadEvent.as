package com.plumbee.stardust.controller.events
{

import flash.events.Event;

public class FileLoadEvent extends Event
{
    public static const LOAD : String = "FileLoadEvent_LOAD";

    public function FileLoadEvent( )
    {
        super( LOAD );
    }

    override public function clone() : Event
    {
        return new FileLoadEvent();
    }
}
}
