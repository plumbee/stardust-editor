/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 15/01/14
 * Time: 17:53
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.display.Graphics;
import flash.events.Event;

public class InitializeZoneDrawerFromEmitterGroupEvent extends Event
{
    public static const INITIALIZE : String = "InitializeZoneDrawerFromEmitterGroupEvent_INITIALIZE";

    private var _targetGraphics : Graphics;

    public function InitializeZoneDrawerFromEmitterGroupEvent( type : String, graphics : Graphics )
    {
        super( type );
        _targetGraphics = graphics;
    }

    public function get targetGraphics() : Graphics
    {
        return _targetGraphics;
    }
}
}
