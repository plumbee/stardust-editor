package com.plumbee.stardust.view.components
{

import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

import spark.components.TextInput;
import spark.events.TextOperationEvent;

public class CustomNumericStepper extends TextInput
{
    public var maximum : Number = 10000000000;
    public var minimum : Number = - 10000000000;
    public var stepValue : Number = 1;

    public function CustomNumericStepper() : void
    {
        restrict = "0-9.\\-";
        addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
        addEventListener( MouseEvent.RIGHT_CLICK, onRightClick );
    }

    private function onRightClick( event : MouseEvent ) : void
    {
        stepValue = Number( text );
        if ( stepValue == 0 )
        {
            stepValue = 1;
        }
    }

    private function onKeyDown( event : KeyboardEvent ) : void
    {
        var keyCode : uint = event.keyCode;
        switch ( keyCode )
        {
            case Keyboard.UP :
                if ( event.ctrlKey )
                {
                    pressUp( stepValue * 10 );
                }
                pressUp( stepValue );
                break;
            case Keyboard.DOWN :
                if ( event.ctrlKey )
                {
                    pressDown( stepValue * 10 );
                }
                pressDown( stepValue );
                break;
        }
    }

    private function updateInput() : void
    {
        var numSteps : Number = Number( text );
        if ( numSteps > maximum )
        {
            numSteps = maximum;
            text = numSteps.toString();
        }
        else if ( numSteps < minimum )
        {
            numSteps = minimum;
            text = numSteps.toString();
        }
        dispatchEvent( new TextOperationEvent( TextOperationEvent.CHANGE ) );
    }

    private function pressUp( step : Number ) : void
    {
        var value : Number = Number( text );
        value += step;
        value = roundValue( value );
        text = value.toString();
        updateInput();
    }

    //incrementing by 0.1 gives really weird rounding errors, so round results to 1 decimal place.
    private function roundValue( value : Number ) : Number
    {
        return Math.round( (value) * 10 ) / 10;
    }

    private function pressDown( step : Number ) : void
    {
        var value : Number = Number( text );
        value -= step;
        value = roundValue( value );
        text = value.toString();
        updateInput();
    }
}
}
