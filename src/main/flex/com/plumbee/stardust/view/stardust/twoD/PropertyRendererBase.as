package com.plumbee.stardust.view.stardust.twoD
{

import flash.events.Event;
import flash.events.MouseEvent;

import flashx.textLayout.formats.VerticalAlign;

import mx.core.IVisualElement;

import spark.components.Button;
import spark.components.CheckBox;
import spark.components.Group;
import spark.components.Label;
import spark.components.List;
import spark.components.supportClasses.ItemRenderer;
import spark.layouts.HorizontalLayout;
import spark.layouts.supportClasses.LayoutBase;

[DefaultProperty("mxmlChildren")]

public class PropertyRendererBase extends ItemRenderer
{
    private const nameLabel : Label = new Label();
    private var removeButton : Button;
    private const contentContainer : Group = new Group();
    private const enabledCB : CheckBox = new CheckBox();
    private var _showRemoveButton : Boolean = true;

    override protected function createChildren() : void
    {
        super.createChildren();
        const hLayout : HorizontalLayout = new HorizontalLayout();
        hLayout.verticalAlign = VerticalAlign.MIDDLE;
        super.layout = hLayout;

        addElement( enabledCB );
        enabledCB.toolTip = "mute";
        enabledCB.addEventListener( Event.CHANGE, onEnabledChangeClick );

        addElement( nameLabel );

        contentContainer.percentWidth = 100;
        addElement( contentContainer );

        if ( _showRemoveButton )
        {
            removeButton = new Button();
            removeButton.label = "Remove";
            removeButton.percentHeight = 100;
            removeButton.addEventListener( MouseEvent.CLICK, onRemoveClick );
            addElement( removeButton );
        }
    }

    override public function set data( d : Object ) : void
    {
        super.data = d;
        if ( d == null )
        {
            return;
        }
        enabledCB.selected = ! data.active;
    }

    private function onEnabledChangeClick( event : Event ) : void
    {
        data.active = ! enabledCB.selected;
    }

    private function onRemoveClick( e : MouseEvent ) : void
    {
        List( owner ).dataProvider.removeItemAt( List( owner ).dataProvider.getItemIndex( data ) );
    }

    public function set mxmlChildren( value : Array ) : void
    {
        contentContainer.removeAllElements();
        for ( var i : int = 0; i < value.length; i ++ )
        {
            contentContainer.addElement( IVisualElement( value[i] ) );
        }
    }

    override public function set layout( val : LayoutBase ) : void
    {
        contentContainer.layout = val;
    }

    override public function get layout() : LayoutBase
    {
        return contentContainer.layout;
    }

    public function set nameText( val : String ) : void
    {
        nameLabel.text = val;
    }

    public function set showRemoveButton( val : Boolean ) : void
    {
        _showRemoveButton = val;
    }

}
}
