/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 16:12
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{

import flash.events.Event;

public class UpdateEmitterDropDownListEvent extends Event
{
    public static const UPDATE : String = "UpdateEmitterDropDownListEvent_UPDATE";

    public function UpdateEmitterDropDownListEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new UpdateEmitterDropDownListEvent( type );
    }
}
}
