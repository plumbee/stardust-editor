/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 15:41
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

import idv.cjcat.stardustextended.common.actions.Action;

public class OnActionACChangeEvent extends Event
{
    //public static const CHANGE : String = "OnActionACChangeEvent_CHANGE";

    private var _action : Action;
    public static const ADD : String = "OnActionACChangeEvent_ADD";
    public static const REMOVE : String = "OnActionACChangeEvent_REMOVE";

    public function OnActionACChangeEvent( type : String, action : Action )
    {
        super( type );
        _action = action;
    }

    override public function clone() : Event
    {
        return new OnActionACChangeEvent( type, _action );
    }

    public function get action() : Action
    {
        return _action;
    }
}
}
