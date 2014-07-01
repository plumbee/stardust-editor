/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 13:12
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class ParticleHandlerUpdateTextInputFromProjectSettingsEvent extends Event
{
    public static const UPDATE : String = "ParticleHandlerUpdateTextInputFromProjectSettingsEvent_UPDATE";

    public function ParticleHandlerUpdateTextInputFromProjectSettingsEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new ParticleHandlerUpdateTextInputFromProjectSettingsEvent( type );
    }
}
}
