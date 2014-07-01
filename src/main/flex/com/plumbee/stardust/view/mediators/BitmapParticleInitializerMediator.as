package com.plumbee.stardust.view.mediators
{

import com.plumbee.stardust.controller.events.RefreshBitmapParticleInitializerRendererEvent;
import com.plumbee.stardust.controller.events.StartSimEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.LoadEmitterImageFromFileReferenceEvent;
import com.plumbee.stardust.view.stardust.twoD.initializers.BitmapParticleInitalizer;

import robotlegs.bender.bundles.mvcs.Mediator;

public class BitmapParticleInitializerMediator extends Mediator
{
    [Inject]
    public var view : BitmapParticleInitalizer;

    [Inject]
    public var projectSettings : ProjectModel;

    override public function initialize() : void
    {
        addViewListener( LoadEmitterImageFromFileReferenceEvent.LOAD, handleLoadImage, LoadEmitterImageFromFileReferenceEvent );
        addViewListener( StartSimEvent.START, handleStartSim, StartSimEvent );

        addContextListener( RefreshBitmapParticleInitializerRendererEvent.TYPE, handleSourceBDChange, RefreshBitmapParticleInitializerRendererEvent );
    }

    private function handleStartSim( event : StartSimEvent ) : void
    {
        dispatch( event );
    }

    private function handleLoadImage( event : LoadEmitterImageFromFileReferenceEvent ) : void
    {
        dispatch( event );
    }

    private function handleSourceBDChange( event : RefreshBitmapParticleInitializerRendererEvent ) : void
    {
        view.updateUI();
    }

}
}
