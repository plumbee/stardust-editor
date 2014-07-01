/**
 * Created with IntelliJ IDEA.
 * User: BenPalc
 * Date: 03/01/14
 * Time: 15:43
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.view.events
{
import flash.events.Event;

import idv.cjcat.stardustextended.common.initializers.Initializer;

public class OnInitializerACChangeEvent extends Event
{
    public static const CHANGE : String = "OnInitializerACChangeEvent_CHANGE";
    public static const ADD : String = "OnInitializerACChangeEvent_ADD";
    public static const REMOVE : String = "OnInitializerACChangeEvent_REMOVE";

    private var _initializer : Initializer;

    public function OnInitializerACChangeEvent( type : String, initializer : Initializer )
    {
        super( type );
        _initializer = initializer;
    }

    override public function clone() : Event
    {
        return new OnInitializerACChangeEvent( type, _initializer );
    }

    public function get initializer() : Initializer
    {
        return _initializer;
    }
}
}
