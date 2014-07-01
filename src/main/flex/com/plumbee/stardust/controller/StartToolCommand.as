package com.plumbee.stardust.controller
{

import com.junkbyte.console.Cc;
import com.plumbee.stardust.controller.events.LoadSimEvent;
import com.plumbee.stardust.debug.FlashConsoleTarget;

import flash.display.DisplayObjectContainer;

import flash.events.IEventDispatcher;

import mx.core.FlexGlobals;

import mx.logging.Log;
import mx.logging.LogEventLevel;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class StartToolCommand implements ICommand
{

    [Inject]
    public var dispatcher : IEventDispatcher;

    // TODO embed a more complex sim
    [Embed(source="../../../../../testAssets/stardustProjectDEFAULT.sde", mimeType="application/octet-stream")]
    private var ExampleSim:Class;

    public function execute() : void
    {
        setupLogging();

        dispatcher.dispatchEvent( new LoadSimEvent(new ExampleSim()) );
    }

    private function setupLogging() : void
    {
        const LOG_FILTERS : Array = ["com.plumbee.*"];
        const LOG_LEVELS : int = LogEventLevel.ALL;
        Cc.startOnStage(FlexGlobals.topLevelApplication as DisplayObjectContainer, "+");
        Cc.config.commandLineAllowed = true;
        Cc.commandLine = true;
        Cc.x = 20;
        Cc.width = 800;
        Cc.height = 400;

        var consoleLogTarget : FlashConsoleTarget = new FlashConsoleTarget();
        consoleLogTarget.includeTime = true;
        consoleLogTarget.includeCategory = true;
        consoleLogTarget.includeLevel = true;
        consoleLogTarget.filters = LOG_FILTERS;
        consoleLogTarget.level = LOG_LEVELS;
        Log.addTarget(consoleLogTarget);
    }
}
}
