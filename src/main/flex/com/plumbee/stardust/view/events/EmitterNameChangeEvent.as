/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 17:20
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import flash.events.Event;

public class EmitterNameChangeEvent extends Event
{
    public static const CHANGE : String = "EmitterNameChangeEvent_CHANGE";

    private var _name : String;
    private var _emitterVO : EmitterValueObject;

    public function EmitterNameChangeEvent( type : String, name : String, emitterVO : EmitterValueObject )
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

    public function get emitterVO() : EmitterValueObject
    {
        return _emitterVO;
    }
}
}
