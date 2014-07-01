/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 19/12/13
 * Time: 10:14
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import flash.events.Event;

public class UpdateEmitterFromViewUICollectionsEvent extends Event
{
    public static const UPDATE : String = "UpdateEmitterFromViewUICollectionsEvent_UPDATE";

    private var _emitterInFocus : EmitterValueObject;

    public function UpdateEmitterFromViewUICollectionsEvent( type : String, emitterInFocus : EmitterValueObject )
    {
        _emitterInFocus = emitterInFocus;
        super( type );
    }

    override public function clone() : Event
    {
        return new UpdateEmitterFromViewUICollectionsEvent( type, _emitterInFocus );
    }

    public function get emitterInFocus() : EmitterValueObject
    {
        return _emitterInFocus;
    }
}
}
