package com.plumbee.stardust.view.mediators
{

import com.plumbee.stardust.controller.events.BackgroundChangeEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.BackgroundProvider;
import com.plumbee.stardust.view.events.RefreshBackgroundViewEvent;

import flash.events.Event;

import robotlegs.bender.bundles.mvcs.Mediator;

public class BackgroundProviderMediator extends Mediator
{
    [Inject]
    public var view : BackgroundProvider;

    [Inject]
    public var projectModel : ProjectModel;

    override public function initialize() : void
    {
        addContextListener( RefreshBackgroundViewEvent.CHANGE, handleModelChange, RefreshBackgroundViewEvent );

        addViewListener( BackgroundChangeEvent.TYPE, handleViewChange, BackgroundChangeEvent );

        view.stage.addEventListener( Event.RESIZE, handleBackgroundResize );
    }

    private function handleViewChange( event : BackgroundChangeEvent ) : void
    {
        dispatch( event );
    }

    private function handleModelChange( event : RefreshBackgroundViewEvent ) : void
    {
        view.setData(projectModel.stadustSim.hasBackground,
                     projectModel.stadustSim.backgroundColor,
                     projectModel.stadustSim.backgroundImage);
    }

    private function handleBackgroundResize( event : Event ) : void
    {
        // TODO
    }
}
}
