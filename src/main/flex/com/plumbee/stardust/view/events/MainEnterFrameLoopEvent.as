/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 16/01/14
 * Time: 14:45
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import com.plumbee.stardust.view.StardusttoolMainView;

import flash.events.Event;

public class MainEnterFrameLoopEvent extends Event
{
    public static const ENTER_FRAME : String = "MainEnterFrameLoopEvent_ENTER_FRAME";

    private var _view : StardusttoolMainView;

    public function MainEnterFrameLoopEvent( type : String, view : StardusttoolMainView )
    {
        super( type );
        _view = view;
    }

    override public function clone() : Event
    {
        return new MainEnterFrameLoopEvent( type, _view );
    }

    public function get view() : StardusttoolMainView
    {
        return _view;
    }
}
}
