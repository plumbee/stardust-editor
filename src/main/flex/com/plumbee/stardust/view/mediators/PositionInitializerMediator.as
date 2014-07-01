/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 06/01/14
 * Time: 11:06
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.mediators
{
import com.plumbee.stardust.view.events.PositionInitializerEmitterPathEvent;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PositionInitializerMediator extends Mediator
{
    override public function initialize() : void
    {
        addViewListener( PositionInitializerEmitterPathEvent.LOAD, handleLoadEmitterPath, PositionInitializerEmitterPathEvent );
    }

    private function handleLoadEmitterPath( event : PositionInitializerEmitterPathEvent ) : void
    {
        dispatch( event );
    }
}
}
