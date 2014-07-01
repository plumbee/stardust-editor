package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.LoadSimEvent;

import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.net.FileFilter;
import flash.net.FileReference;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class FileLoadCommand implements ICommand
{

    private var _loadFile : FileReference;

    [Inject]
    public var dispatcher : IEventDispatcher;

    public function execute() : void
    {
        _loadFile = new FileReference();
        _loadFile.addEventListener( Event.SELECT, selectHandler );
        _loadFile.browse( [new FileFilter( "Stardust editor project: (*.sde)", "*.sde" )] );
    }

    private function selectHandler( event : Event ) : void
    {
        _loadFile.removeEventListener( Event.SELECT, selectHandler );
        _loadFile.addEventListener( Event.COMPLETE, loadCompleteHandler );
        _loadFile.load();
    }

    private function loadCompleteHandler( event : Event ) : void
    {
        _loadFile.removeEventListener( Event.COMPLETE, loadCompleteHandler );
        dispatcher.dispatchEvent( new LoadSimEvent(_loadFile.data) );
    }

}
}

