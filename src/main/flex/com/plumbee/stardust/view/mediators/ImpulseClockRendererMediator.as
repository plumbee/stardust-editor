/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 02/01/14
 * Time: 21:16
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.mediators
{
import com.plumbee.stardust.controller.events.UpdateClockValuesFromModelEvent;
import com.plumbee.stardust.controller.events.UpdateImpulseClockRendererEvent;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.events.ImpulseClockRendererSetDataEvent;
import com.plumbee.stardust.view.events.ImpulseClockRendererUpdateEmitterInfoEvent;
import com.plumbee.stardust.view.events.UpdateClockInEmitterGroupEvent;
import com.plumbee.stardust.view.stardust.common.clocks.ImpulseClockRenderer;
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ImpulseClockRendererMediator extends Mediator
{
    [Inject]
    public var view : ImpulseClockRenderer;

    [Inject]
    public var projectSettings : ProjectModel;

    override public function initialize() : void
    {
        addViewListener( ImpulseClockRendererSetDataEvent.SET, handleSetData, ImpulseClockRendererSetDataEvent );
        addViewListener( UpdateClockInEmitterGroupEvent.UPDATE, handleUpdateEmitterGroup, UpdateClockInEmitterGroupEvent );
        addViewListener( ImpulseClockRendererUpdateEmitterInfoEvent.UPDATE, handleUpdateEmitterInfo, ImpulseClockRendererUpdateEmitterInfoEvent );

        addContextListener( UpdateImpulseClockRendererEvent.UPDATE, handleUpdateFromContext, UpdateImpulseClockRendererEvent );

        //when view/mediator ready, get the values;
        dispatch( new UpdateClockValuesFromModelEvent( UpdateClockValuesFromModelEvent.UPDATE ) );
    }


    private function handleSetData( event : ImpulseClockRendererSetDataEvent ) : void
    {
        var emitterVO : BaseEmitterValueObject = projectSettings.emitterInFocus;

        view.updateTextFieldsFromEmitterVO( emitterVO );
    }

    private function handleUpdateEmitterGroup( event : UpdateClockInEmitterGroupEvent ) : void
    {
        dispatch( event );
    }

    private function handleUpdateEmitterInfo( event : ImpulseClockRendererUpdateEmitterInfoEvent ) : void
    {
        dispatch( event );
    }

    private function handleUpdateFromContext( event : UpdateImpulseClockRendererEvent ) : void
    {
        view.setData( event.clock );
    }
}
}
