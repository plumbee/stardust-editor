/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 19/12/13
 * Time: 16:22
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.mediators
{
import com.plumbee.stardust.controller.events.EmitterInfoTicksPerCallChangeEvent;
import com.plumbee.stardust.controller.events.UpdateClockValuesFromModelEvent;
import com.plumbee.stardust.controller.events.UpdateSteadyClockRendererEvent;
import com.plumbee.stardust.view.events.UpdateEmitterInfoTicksPerCallEvent;
import com.plumbee.stardust.view.stardust.common.clocks.SteadyClockRenderer;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SteadyClockRendererMediator extends Mediator
{
    [Inject]
    public var view : SteadyClockRenderer;

    override public function initialize() : void
    {
        addViewListener( EmitterInfoTicksPerCallChangeEvent.CHANGE, handleUpdateEmitterInfoTicksPerCall, EmitterInfoTicksPerCallChangeEvent );

        addContextListener( UpdateSteadyClockRendererEvent.UPDATE, handleUpdateFromContext, UpdateSteadyClockRendererEvent );

        //when view/mediator ready, get the values;
        dispatch( new UpdateClockValuesFromModelEvent( UpdateClockValuesFromModelEvent.UPDATE ) );
    }

    private function handleUpdateEmitterInfoTicksPerCall( event : EmitterInfoTicksPerCallChangeEvent ) : void
    {
        var ticksPerCall : Number = event.ticksPerCall;

        dispatch( new UpdateEmitterInfoTicksPerCallEvent( UpdateEmitterInfoTicksPerCallEvent.UPDATE, ticksPerCall ) );
    }

    private function handleUpdateFromContext( event : UpdateSteadyClockRendererEvent ) : void
    {
        view.setData( event.clock, event.ticksPerCall );
    }
}
}
