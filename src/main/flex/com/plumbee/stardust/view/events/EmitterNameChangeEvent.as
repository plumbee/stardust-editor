/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 17:20
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;

import flash.events.Event;

public class EmitterNameChangeEvent extends Event
{
    public static const CHANGE : String = "EmitterNameChangeEvent_CHANGE";

    private var _name : String;
    private var _emitterVO : BaseEmitterValueObject;

    public function EmitterNameChangeEvent( type : String, name : String, emitterVO : BaseEmitterValueObject )
    {
        super( type );
        _name = name;
        _emitterVO = emitterVO;
    }

    override public function clone() : Event
    {
        return new EmitterNameChangeEvent( type, _name, _emitterVO );
    }

    public function get name() : String
    {
        return _name;
    }

    public function get emitterVO() : BaseEmitterValueObject
    {
        return _emitterVO;
    }
}
}
