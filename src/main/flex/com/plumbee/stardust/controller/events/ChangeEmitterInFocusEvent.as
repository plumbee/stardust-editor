/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 16:10
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;

import flash.events.Event;

import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;

public class ChangeEmitterInFocusEvent extends Event
{
    public static const CHANGE : String = "ChangeEmitterInFocusEvent_CHANGE";

    private var _emitter : BaseEmitterValueObject;

    public function ChangeEmitterInFocusEvent( type : String, emitter : BaseEmitterValueObject )
    {
        super( type );
        _emitter = emitter;
    }

    override public function clone() : Event
    {
        return new ChangeEmitterInFocusEvent( type, emitter );
    }

    public function get emitter() : BaseEmitterValueObject
    {
        return _emitter;
    }
}
}
