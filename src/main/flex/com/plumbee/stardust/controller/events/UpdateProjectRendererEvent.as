/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 20/12/13
 * Time: 16:28
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.controller.events
{
import flash.events.Event;

public class UpdateProjectRendererEvent extends Event
{
    public static const UPDATE : String = "update";

    public function UpdateProjectRendererEvent( type : String )
    {
        super( type );
    }

    override public function clone() : Event
    {
        return new UpdateProjectRendererEvent( type );
    }
}
}
