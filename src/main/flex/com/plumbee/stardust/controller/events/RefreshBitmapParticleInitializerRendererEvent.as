/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 23/12/13
 * Time: 14:13
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class RefreshBitmapParticleInitializerRendererEvent extends Event
{
    public static const TYPE : String = "RefreshBitmapParticleInitializerRendererEvent_COMPLETE";

    public function RefreshBitmapParticleInitializerRendererEvent()
    {
        super( TYPE );
    }

    override public function clone() : Event
    {
        return new RefreshBitmapParticleInitializerRendererEvent();
    }
}
}
