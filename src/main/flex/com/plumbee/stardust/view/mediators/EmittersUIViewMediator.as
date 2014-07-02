/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 14:35
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.mediators
{
import com.plumbee.stardust.controller.events.ChangeEmitterInFocusEvent;
import com.plumbee.stardust.controller.events.EmitterChangeEvent;
import com.plumbee.stardust.controller.events.SetResultsForEmitterDropDownListEvent;
import com.plumbee.stardust.view.EmittersUIView;
import com.plumbee.stardust.view.events.EmitterChangeUIViewEvent;
import com.plumbee.stardust.view.events.EmitterNameChangeEvent;

import robotlegs.bender.bundles.mvcs.Mediator;

public class EmittersUIViewMediator extends Mediator
{
    [Inject]
    public var view : EmittersUIView;

    override public function initialize() : void
    {
        addViewListener( EmitterChangeUIViewEvent.ADD, handleAddEmitterButton, EmitterChangeUIViewEvent );
        addViewListener( EmitterChangeUIViewEvent.REMOVE, handleRemoveEmitterButton, EmitterChangeUIViewEvent );
        addViewListener( EmitterNameChangeEvent.CHANGE, handleNameChangeEvent, EmitterNameChangeEvent );
        addViewListener( ChangeEmitterInFocusEvent.CHANGE, handleChangeEmitterInFocusEvent, ChangeEmitterInFocusEvent );

        addContextListener( SetResultsForEmitterDropDownListEvent.UPDATE, handleSetResultsDropDownListEvent, SetResultsForEmitterDropDownListEvent );
    }

    private function handleChangeEmitterInFocusEvent( event : ChangeEmitterInFocusEvent ) : void
    {
        dispatch( new ChangeEmitterInFocusEvent( ChangeEmitterInFocusEvent.CHANGE, event.emitter ) );
    }

    private function handleAddEmitterButton( event : EmitterChangeUIViewEvent ) : void
    {
        dispatch( new EmitterChangeEvent( EmitterChangeEvent.ADD ) );
    }

    private function handleRemoveEmitterButton( event : EmitterChangeUIViewEvent ) : void
    {
        dispatch( new EmitterChangeEvent( EmitterChangeEvent.REMOVE ) );
    }

    private function handleNameChangeEvent( event : EmitterNameChangeEvent ) : void
    {
        dispatch( new EmitterNameChangeEvent( EmitterNameChangeEvent.CHANGE, event.name, event.emitterVO ) );
    }

    private function handleSetResultsDropDownListEvent( event : SetResultsForEmitterDropDownListEvent ) : void
    {
        view.setDropDownListResult( event.list, event.emitterInFocus );
    }
}
}
