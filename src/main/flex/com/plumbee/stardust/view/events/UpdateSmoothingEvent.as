/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 14/02/14
 * Time: 13:44
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

import spark.components.CheckBox;

public class UpdateSmoothingEvent extends Event
{
    public static const UPDATE : String = "UpdateSmoothingEvent_UPDATE";
    private var _useSmoothing : Boolean;

    public function UpdateSmoothingEvent( useSmoothing : Boolean )
    {
        super( UPDATE );
        _useSmoothing = useSmoothing;
    }

    override public function clone() : Event
    {
        return new UpdateSmoothingEvent( _useSmoothing );
    }

    public function get useSmoothing() : Boolean
    {
        return _useSmoothing;
    }
}
}
