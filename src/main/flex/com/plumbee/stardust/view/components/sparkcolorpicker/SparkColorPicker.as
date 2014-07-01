package com.plumbee.stardust.view.components.sparkcolorpicker
{

import flash.display.DisplayObject;
import flash.events.Event;

import mx.collections.IList;
import mx.controls.colorPickerClasses.WebSafePalette;
import mx.graphics.SolidColor;

import spark.components.ComboBox;
import spark.events.DropDownEvent;

/**
 *  Subclass DropDownList and make it work like a ColorPicker
 */
public class SparkColorPicker extends ComboBox
{

    private var wsp : WebSafePalette;

    [SkinPart(required="false")]
    public var current : SolidColor;

    public function SparkColorPicker()
    {
        super();
        wsp = new WebSafePalette();
        super.dataProvider = wsp.getList();
        labelFunction = blank;
        labelToItemFunction = colorFunction;
        openOnInput = false;
        addEventListener( Event.CHANGE, colorChangeHandler );
    }

    public function get selectedColor() : uint
    {
        return current.color;
    }

    private static function colorFunction( value : String ) : *
    {
        return uint( value );
    }

    private function colorChangeHandler( event : Event ) : void
    {
        if ( current )
        {
            current.color = selectedItem;
        }
    }

    private static function blank( item : Object ) : String
    {
        return "";
    }

    // don't allow anyone to set our custom DP
    override public function set dataProvider( value : IList ) : void
    {
    }

    /**
     *  @private
     */
    override protected function partAdded( partName : String, instance : Object ) : void
    {
        super.partAdded( partName, instance );

        if ( instance == current )
            current.color = selectedItem;
    }

    override public function setFocus() : void
    {
        stage.focus = this;
    }

    override protected function isOurFocus( target : DisplayObject ) : Boolean
    {
        return target == this;
    }

    override protected function dropDownController_closeHandler( event : DropDownEvent ) : void
    {
        event.preventDefault();
        super.dropDownController_closeHandler( event );
    }
}

}
