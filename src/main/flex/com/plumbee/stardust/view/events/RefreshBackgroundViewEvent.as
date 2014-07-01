package com.plumbee.stardust.view.events
{

import flash.events.Event;

public class RefreshBackgroundViewEvent extends Event
{

    public static const CHANGE : String = "RefreshBackgroundViewEvent_Event";

    public function RefreshBackgroundViewEvent( )
    {
        super( CHANGE );
    }

    override public function clone() : Event
    {
        return new RefreshBackgroundViewEvent();
    }
}
}
