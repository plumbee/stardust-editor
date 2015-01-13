/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 16/01/14
 * Time: 14:45
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import com.plumbee.stardust.view.IStardustToolMainView;

import flash.events.Event;

public class MainEnterFrameLoopEvent extends Event
{
	public static const ENTER_FRAME : String = "MainEnterFrameLoopEvent_ENTER_FRAME";

	public function MainEnterFrameLoopEvent(type : String, view : IStardustToolMainView)
	{
		super(type);
		_view = view;
	}

	private var _view : IStardustToolMainView;

	public function get view() : IStardustToolMainView
	{
		return _view;
	}

	override public function clone() : Event
	{
		return new MainEnterFrameLoopEvent(type, _view);
	}
}
}
