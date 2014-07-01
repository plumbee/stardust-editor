package com.plumbee.stardust.helpers
{
import flash.display.Graphics;
import flash.geom.Point;
import flash.utils.getQualifiedClassName;

import idv.cjcat.stardustextended.common.actions.Action;
import idv.cjcat.stardustextended.common.emitters.Emitter;
import idv.cjcat.stardustextended.common.initializers.Initializer;
import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.actions.DeathZone;
import idv.cjcat.stardustextended.twoD.actions.Deflect;
import idv.cjcat.stardustextended.twoD.actions.FollowWaypoints;
import idv.cjcat.stardustextended.twoD.actions.waypoints.Waypoint;
import idv.cjcat.stardustextended.twoD.deflectors.CircleDeflector;
import idv.cjcat.stardustextended.twoD.deflectors.Deflector;
import idv.cjcat.stardustextended.twoD.deflectors.LineDeflector;
import idv.cjcat.stardustextended.twoD.deflectors.WrappingBox;
import idv.cjcat.stardustextended.twoD.initializers.PositionAnimated;
import idv.cjcat.stardustextended.twoD.zones.CircleContour;
import idv.cjcat.stardustextended.twoD.zones.CircleZone;
import idv.cjcat.stardustextended.twoD.zones.Composite;
import idv.cjcat.stardustextended.twoD.zones.Line;
import idv.cjcat.stardustextended.twoD.zones.RectContour;
import idv.cjcat.stardustextended.twoD.zones.RectZone;
import idv.cjcat.stardustextended.twoD.zones.Sector;
import idv.cjcat.stardustextended.twoD.zones.SinglePoint;
import idv.cjcat.stardustextended.twoD.zones.Zone;

import mx.logging.ILogger;
import mx.logging.Log;

use namespace sd;

/** static helper function to visualize com.plumbee.stardust.view.zones */
public class ZoneDrawer
{

    private static const LOG : ILogger = Log.getLogger( getQualifiedClassName( ZoneDrawer ).replace( "::", "." ) );

    private static var emitter : Emitter;
    private static var graphics : Graphics;

    public static function init( e : Emitter, g : Graphics ) : void
    {
        emitter = e;
        graphics = g;
    }

    public static function drawZones() : void
    {
        if ( emitter == null || graphics == null )
        {
            return;
        }
        graphics.clear();
        for each ( var init : Initializer in emitter.sd::initializers )
        {
            if ( init is PositionAnimated )
            {
                drawZone( graphics, PositionAnimated( init ).zone, 0x75FF56, PositionAnimated( init ).currentPosition );
            }
        }
        for each ( var act : Action in emitter.sd::actions )
        {
            if ( act is DeathZone )
            {
                drawZone( graphics, DeathZone( act ).zone, 0xE03535, null );
            }
            else if ( act is Deflect )
            {
                drawDeflector( graphics, Deflect( act ), 0x6D83FF );
            }
            else if ( act is FollowWaypoints )
            {
                drawWaypoints( graphics, FollowWaypoints( act ), 0xFFFB30 );
            }
        }
    }

    private static function drawWaypoints( g : Graphics, wps : FollowWaypoints, color : uint ) : void
    {
        g.beginFill( color, 0.7 );
        g.lineStyle( 2, darkenColor( color, 50 ) );
        for each ( var wp : Waypoint in wps.waypoints )
        {
            g.drawCircle( wp.x, wp.y, wp.radius );
        }
        g.endFill();
    }

    private static function drawDeflector( g : Graphics, d : Deflect, color : uint ) : void
    {
        g.beginFill( color, 0.7 );
        g.lineStyle( 2, darkenColor( color, 50 ) );
        for each ( var def : Deflector in d.deflectors )
        {
            if ( def is CircleDeflector )
            {
                var cd : CircleDeflector = CircleDeflector( def );
                g.drawCircle( cd.x, cd.y, cd.radius );
            }
            else if ( def is WrappingBox )
            {
                var wb : WrappingBox = WrappingBox( def );
                g.drawRect( wb.x, wb.y, wb.width, wb.height )
            }
            else if ( def is LineDeflector )
            {
                var ld : LineDeflector = LineDeflector( def );
                g.moveTo( ld.x, ld.y );
                g.lineTo( ld.x + ld.normal.y * 100, ld.y - ld.normal.x * 100 );
            }
        }
        g.endFill();
    }

    private static function drawZone( g : Graphics, z : Zone, color : uint, offset : Point ) : void
    {
        if ( offset == null )
        {
            offset = new Point( 0, 0 );
        }
        g.beginFill( color, 0.7 );
        g.lineStyle( 2, darkenColor( color, 50 ) );
        if ( z is SinglePoint )
        {
            var sp : SinglePoint = SinglePoint( z );
            g.drawCircle( sp.x - 1 + offset.x, sp.y - 1 + offset.y, 2 );
        }
        else if ( z is Line )
        {
            var li : Line = Line( z );
            g.moveTo( li.x1 + offset.x, li.y1 + offset.y );
            g.lineTo( li.x2 + offset.x, li.y2 + offset.y );
        }
        else if ( z is RectZone )
        {
            var re : RectZone = RectZone( z );
            g.drawRect( re.x + offset.x, re.y + offset.y, re.width, re.height );
        }
        else if ( z is RectContour )
        {
            var rc : RectContour = RectContour( z );
            g.endFill();
            g.drawRect( rc.x + offset.x, rc.y + offset.y, rc.width, rc.height );
        }
        else if ( z is CircleZone )
        {
            var cz : CircleZone = CircleZone( z );
            g.drawCircle( cz.x + offset.x, cz.y + offset.y, cz.radius );
        }
        else if ( z is CircleContour )
        {
            var cc : CircleContour = CircleContour( z );
            g.endFill();
            g.drawCircle( cc.x + offset.x, cc.y + offset.y, cc.radius );
        }
        else if ( z is Sector )
        {
            var se : Sector = Sector( z );
            drawSector(g, se.x + offset.x, se.y + offset.y, se.minRadius, se.maxRadius, se.minAngle, se.maxAngle);
        }
        else if ( z is Composite )
        {
            var co : Composite = Composite( z );
            for (var i:int = 0; i < co.zones.length; i++) {
                drawZone(g, co.zones[i], color, offset);
            }
        }
        else
        {
            LOG.error( "ZoneDrawer: unknown zone " + z );
        }
        g.endFill();
    }

    public static function darkenColor( hexColor : Number, percent : Number ) : Number
    {
        if ( isNaN( percent ) )
            percent = 0;
        if ( percent > 100 )
            percent = 100;
        if ( percent < 0 )
            percent = 0;

        var factor : Number = 1 - (percent / 100);
        var rgb : Object = hexToRgb( hexColor );

        rgb.r *= factor;
        rgb.b *= factor;
        rgb.g *= factor;

        return rgbToHex( Math.round( rgb.r ), Math.round( rgb.g ), Math.round( rgb.b ) );
    }

    public static function rgbToHex( r : Number, g : Number, b : Number ) : Number
    {
        return(r << 16 | g << 8 | b);
    }

    public static function hexToRgb( hex : Number ) : Object
    {
        return {r : (hex & 0xff0000) >> 16, g : (hex & 0x00ff00) >> 8, b : hex & 0x0000ff};
    }

    // modified from http://www.pixelwit.com/blog/2008/12/drawing-closed-arc-shape/
    private static function drawSector(graphics : Graphics, centerX : Number, centerY: Number,
                                       innerRadius : Number, outerRadius : Number,
                                       startAngle : Number, endAngle : Number) : void
    {
        startAngle = startAngle/360;
        endAngle = endAngle/360;
        const steps : int = 30;
        const twoPI : Number = 2 * Math.PI;
        const angleStep : Number = (endAngle - startAngle)/steps;

        var xx : Number = centerX + Math.cos(startAngle * twoPI) * innerRadius;
        var yy : Number= centerY + Math.sin(startAngle * twoPI) * innerRadius;
        const startPoint : Point = new Point(xx, yy);

        graphics.moveTo(xx, yy);
        var angle : Number;
        // Draw the inner arc.
        for (var i : int = 1; i<=steps; i++){
            angle = (startAngle + i * angleStep) * twoPI;
            xx = centerX + Math.cos(angle) * innerRadius;
            yy = centerY + Math.sin(angle) * innerRadius;
            graphics.lineTo(xx, yy);
        }

        // Draw the outer arc.
        for (i=0; i<=steps; i++){
            angle = (endAngle - i * angleStep) * twoPI;
            xx = centerX + Math.cos(angle) * outerRadius;
            yy = centerY + Math.sin(angle) * outerRadius;
            graphics.lineTo(xx, yy);
        }

        graphics.lineTo(startPoint.x, startPoint.y);
    }
}
}
