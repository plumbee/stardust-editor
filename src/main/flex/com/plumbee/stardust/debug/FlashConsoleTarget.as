/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 31/10/13
 * Time: 12:09
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.debug
{
import com.junkbyte.console.Cc;

import mx.core.mx_internal;
import mx.logging.LogEvent;
import mx.logging.LogEventLevel;
import mx.logging.targets.LineFormattedTarget;

use namespace mx_internal;

public class FlashConsoleTarget extends LineFormattedTarget
{
    private var pendingMessage : String;

    public function FlashConsoleTarget()
    {
        super();
    }

    override public function logEvent( event : LogEvent ) : void
    {
        super.logEvent( event );

        switch ( event.level )
        {
            case LogEventLevel.INFO:
                Cc.info( pendingMessage );
                break;
            case LogEventLevel.DEBUG:
                Cc.debug( pendingMessage );
                break;
            case LogEventLevel.WARN:
                Cc.warn( pendingMessage );
                break;
            case LogEventLevel.ERROR:
                Cc.error( pendingMessage );
                break;
            case LogEventLevel.FATAL:
                Cc.fatal( pendingMessage );
                break;
            default:
                // ignore message of unknown level
                break;
        }
    }

    override mx_internal function internalLog( message : String ) : void
    {
        pendingMessage = message;
    }
}
}
