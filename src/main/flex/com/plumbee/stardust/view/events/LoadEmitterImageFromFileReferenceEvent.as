/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 18:40
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

public class LoadEmitterImageFromFileReferenceEvent extends Event
{
    public static const LOAD : String = "LoadEmitterImageFromFileReferenceEvent_LOAD";

    public function LoadEmitterImageFromFileReferenceEvent()
    {
        super( LOAD );
    }

    override public function clone() : Event
    {
        return new LoadEmitterImageFromFileReferenceEvent();
    }
}
}
