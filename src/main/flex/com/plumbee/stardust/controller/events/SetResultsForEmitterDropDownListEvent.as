/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 24/12/13
 * Time: 09:09
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import flash.events.Event;

public class SetResultsForEmitterDropDownListEvent extends Event
{
    public static const UPDATE : String = "SetResultsForEmitterDropDownListEvent_UPDATE";
    private var _list : Array;
    private var _emitterInFocus : EmitterValueObject;

    public function SetResultsForEmitterDropDownListEvent( type : String, list : Array, emitterInFocus : EmitterValueObject )
    {
        super( type );
        _list = list;
        _emitterInFocus = emitterInFocus;
    }

    override public function clone() : Event
    {
        return new SetResultsForEmitterDropDownListEvent( type, _list, _emitterInFocus );
    }

    public function get list() : Array
    {
        return _list;
    }

    public function get emitterInFocus() : EmitterValueObject
    {
        return _emitterInFocus;
    }
}
}
