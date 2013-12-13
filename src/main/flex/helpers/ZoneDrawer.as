package helpers
{
import flash.display.Graphics;
import idv.cjcat.stardust.common.actions.Action;

import idv.cjcat.stardust.common.emitters.Emitter;
import idv.cjcat.stardust.common.initializers.Initializer;
import idv.cjcat.stardust.sd;
import idv.cjcat.stardust.twoD.actions.DeathZone;
import idv.cjcat.stardust.twoD.actions.Deflect;
import idv.cjcat.stardust.twoD.actions.FollowWaypoints;
import idv.cjcat.stardust.twoD.actions.waypoints.Waypoint;
import idv.cjcat.stardust.twoD.deflectors.CircleDeflector;
import idv.cjcat.stardust.twoD.deflectors.Deflector;
import idv.cjcat.stardust.twoD.deflectors.LineDeflector;
import idv.cjcat.stardust.twoD.deflectors.WrappingBox;
import idv.cjcat.stardust.twoD.initializers.Position;
import idv.cjcat.stardust.twoD.zones.CircleContour;
import idv.cjcat.stardust.twoD.zones.CircleZone;
import idv.cjcat.stardust.twoD.zones.Line;
import idv.cjcat.stardust.twoD.zones.RectContour;
import idv.cjcat.stardust.twoD.zones.RectZone;
import idv.cjcat.stardust.twoD.zones.SinglePoint;
import idv.cjcat.stardust.twoD.zones.Zone;

use namespace sd;
/** static helper function to visualize view.zones */
public class ZoneDrawer
{

    private static var emitter:Emitter;
    private static var graphics:Graphics;

    public static function init(e:Emitter, g:Graphics) : void
    {
        emitter = e;
        graphics = g;
    }

    public static function drawZones() : void
    {
        if (emitter == null || graphics == null)
        {
            return;
        }
        graphics.clear();
        for each (var init:Initializer in emitter.sd::initializers)
        {
            if (init is Position)
            {
                drawZone( graphics, Position(init).zone, 0x75FF56 );
            }
        }
        for each (var act:Action in emitter.sd::actions)
        {
            if (act is DeathZone)
            {
                drawZone( graphics, DeathZone(act).zone, 0xE03535 );
            }
            else if (act is Deflect)
            {
                drawDeflector( graphics, Deflect(act) , 0x6D83FF );
            }
            else if (act is FollowWaypoints)
            {
                drawWaypoints( graphics, FollowWaypoints(act) , 0xFFFB30 );
            }
        }
    }

    private static function drawWaypoints(g:Graphics, wps:FollowWaypoints, color:uint):void
    {
        g.beginFill(color, 0.7);
        g.lineStyle(2, darkenColor(color, 50) );
        for each (var wp:Waypoint in wps.waypoints )
        {
            g.drawCircle( wp.x, wp.y, wp.radius );
        }
        g.endFill();
    }

    private static function drawDeflector(g:Graphics, d:Deflect, color:uint):void
    {
        g.beginFill(color, 0.7);
        g.lineStyle(2, darkenColor(color, 50) );
        for each (var def:Deflector in d.deflectors )
        {
            if (def is CircleDeflector)
            {
                var cd:CircleDeflector = CircleDeflector(def);
                g.drawCircle( cd.x, cd.y, cd.radius );
            }
            else if (def is WrappingBox)
            {
                var wb:WrappingBox = WrappingBox(def);
                g.drawRect(wb.x, wb.y, wb.width, wb.height)
            }
            else if (def is LineDeflector)
            {
                var ld:LineDeflector = LineDeflector(def);
                g.moveTo( ld.x,  ld.y );
                g.lineTo( ld.x+ld.normal.y*100, ld.y-ld.normal.x*100 );
            }
        }
        g.endFill();
    }

    private static function drawZone(g:Graphics, z:Zone, color:uint):void
    {
        g.beginFill(color, 0.7);
        g.lineStyle(2, darkenColor(color, 50) );
        if (z is SinglePoint)
        {
            var sp:SinglePoint = SinglePoint(z);
            g.drawCircle( sp.x-1,sp.y-1,2 );
        }
        else if (z is Line)
        {
            var li:Line = Line(z);
            g.moveTo( li.x1, li.y1 );
            g.lineTo( li.x2, li.y2 );
        }
        else if (z is RectZone)
        {
            var re:RectZone = RectZone(z);
            g.drawRect(re.x, re.y, re.width, re.height);
        }
        else if (z is RectContour)
        {
            var rc:RectContour = RectContour(z);
            g.endFill();
            g.drawRect(rc.x, rc.y, rc.width, rc.height);
        }
        else if (z is CircleZone)
        {
            var cz:CircleZone = CircleZone(z);
            g.drawCircle(cz.x, cz.y, cz.radius);
        }
        else if (z is CircleContour)
        {
            var cc:CircleContour = CircleContour(z);
            g.endFill();
            g.drawCircle(cc.x, cc.y, cc.radius);
        }
        else
        {
            trace("ZoneDrawer: unkown zone "+z);
        }
        g.endFill();
    }

    public static function darkenColor(hexColor:Number, percent:Number):Number{
        if(isNaN(percent))
            percent=0;
        if(percent>100)
            percent=100;
        if(percent<0)
            percent=0;

        var factor:Number=1-(percent/100);
        var rgb:Object=hexToRgb(hexColor);

        rgb.r*=factor;
        rgb.b*=factor;
        rgb.g*=factor;

        return rgbToHex(Math.round(rgb.r),Math.round(rgb.g),Math.round(rgb.b));
    }

    public static function rgbToHex(r:Number, g:Number, b:Number):Number {
        return(r<<16 | g<<8 | b);
    }

    public static function hexToRgb (hex:Number):Object{
        return {r:(hex & 0xff0000) >> 16,g:(hex & 0x00ff00) >> 8,b:hex & 0x0000ff};
    }
}
}
