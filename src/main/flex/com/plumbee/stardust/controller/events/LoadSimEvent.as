package com.plumbee.stardust.controller.events
{

import flash.events.Event;
import flash.utils.ByteArray;

public class LoadSimEvent extends Event
{
    public static const LOAD : String = "LoadSimEvent_LOAD";
    private var _sdeFile : ByteArray;

    public function LoadSimEvent( sdeFileToLoad : ByteArray )
    {
        _sdeFile = sdeFileToLoad;
        super( LOAD );
    }

    override public function clone() : Event
    {
        return new LoadSimEvent(_sdeFile);
    }

    public function get sdeFile() : ByteArray
    {
        return _sdeFile;
    }
}
}
