package helpers {
import flash.utils.getQualifiedClassName;

import idv.cjcat.stardust.common.actions.Action;
import idv.cjcat.stardust.common.actions.Age;
import idv.cjcat.stardust.common.actions.AlphaCurve;
import idv.cjcat.stardust.common.actions.DeathLife;
import idv.cjcat.stardust.common.actions.ScaleCurve;
import idv.cjcat.stardust.common.clocks.Clock;
import idv.cjcat.stardust.common.clocks.ImpulseClock;
import idv.cjcat.stardust.common.clocks.SteadyClock;

import idv.cjcat.stardust.common.initializers.Alpha;
import idv.cjcat.stardust.common.initializers.CollisionRadius;
import idv.cjcat.stardust.common.initializers.Initializer;
import idv.cjcat.stardust.common.initializers.Life;
import idv.cjcat.stardust.common.initializers.Mask;
import idv.cjcat.stardust.common.initializers.Mass;
import idv.cjcat.stardust.common.initializers.Scale;
import idv.cjcat.stardust.common.math.Random;
import idv.cjcat.stardust.common.math.UniformRandom;
import idv.cjcat.stardust.sd;
import idv.cjcat.stardust.twoD.actions.Accelerate;
import idv.cjcat.stardust.twoD.actions.Collide;
import idv.cjcat.stardust.twoD.actions.Damping;
import idv.cjcat.stardust.twoD.actions.DeathZone;
import idv.cjcat.stardust.twoD.actions.Deflect;
import idv.cjcat.stardust.twoD.actions.FollowWaypoints;
import idv.cjcat.stardust.twoD.actions.Gravity;
import idv.cjcat.stardust.twoD.actions.Move;
import idv.cjcat.stardust.twoD.actions.MutualGravity;
import idv.cjcat.stardust.twoD.actions.Oriented;
import idv.cjcat.stardust.twoD.actions.RandomDrift;
import idv.cjcat.stardust.twoD.actions.SpeedLimit;
import idv.cjcat.stardust.twoD.actions.Spin;
import idv.cjcat.stardust.twoD.actions.VelocityField;
import idv.cjcat.stardust.twoD.actions.waypoints.Waypoint;
import idv.cjcat.stardust.twoD.deflectors.CircleDeflector;
import idv.cjcat.stardust.twoD.deflectors.Deflector;
import idv.cjcat.stardust.twoD.deflectors.LineDeflector;
import idv.cjcat.stardust.twoD.deflectors.WrappingBox;
import idv.cjcat.stardust.twoD.emitters.Emitter2D;
import idv.cjcat.stardust.twoD.fields.Field;
import idv.cjcat.stardust.twoD.fields.RadialField;
import idv.cjcat.stardust.twoD.fields.UniformField;
import idv.cjcat.stardust.twoD.initializers.Omega;
import idv.cjcat.stardust.twoD.initializers.PooledDisplayObjectClass;
import idv.cjcat.stardust.twoD.initializers.Position;
import idv.cjcat.stardust.twoD.initializers.Velocity;
import idv.cjcat.stardust.twoD.zones.Line;
import idv.cjcat.stardust.twoD.zones.RectZone;
import idv.cjcat.stardust.twoD.zones.SinglePoint;
import idv.cjcat.stardust.twoD.zones.Zone;

use namespace sd;

public class StadustElementParser
{
    private static const EMITTERNAME : String = "myEmitter";

    public static function parseStardustSim( emitter2D:Emitter2D ) : String
    {
        var ret : String = "";
        ret += "var "+EMITTERNAME+":Emitter2D = new Emitter2D();\n";
        ret += parseClock(emitter2D.clock);
        for each ( var initializer:Initializer in emitter2D.sd::initializers )
        {
            var istr : String = "Cannot parse initializer "+getQualifiedClassName(initializer);
            if (initializer is Alpha)
            {
                istr = "new Alpha("+parseRandom( Alpha(initializer).random )+")";
            }
            else if (initializer is CollisionRadius)
            {
                istr = "new CollisionRadius("+CollisionRadius(initializer).radius+")";
            }
            else if (initializer is PooledDisplayObjectClass)
            {
                istr = "new PooledDisplayObjectClass("+
                        PooledDisplayObjectClass(initializer).displayObjectClass+", "+
                        PooledDisplayObjectClass(initializer).constructorParams+")";
            }
            else if (initializer is Life)
            {
                istr = "new Life("+parseRandom(Life(initializer).random)+")";
            }
            else if (initializer is Mask)
            {
                istr = "new Mask("+Mask(initializer).mask+")";
            }
            else if (initializer is Mass)
            {
                istr = "new Mass("+parseRandom(Mass(initializer).random)+")";
            }
            else if (initializer is Omega)
            {
                istr = "new Omega("+parseRandom(Omega(initializer).random)+")";
            }
            else if (initializer is Position)
            {
                istr = "new Position("+parseZone(Position(initializer).zone)+")";
            }
            else if (initializer is Scale)
            {
                istr = "new Scale("+parseRandom(Scale(initializer).random)+")";
            }
            else if (initializer is Velocity)
            {
                istr = "new Velocity("+parseZone(Velocity(initializer).zone)+")";
            }
            ret += EMITTERNAME+".addInitializer( "+istr+" );\n";
        }
        //// actions
        for each ( var action:Action in emitter2D.sd::actions )
        {
            var astr : String = "Cannot parse action "+getQualifiedClassName(action);
            if (action is Accelerate)
            {
                astr = "new Accelerate("+ Accelerate(action).acceleration+")";
            }
            else if (action is Age)
            {
                astr = "new Age("+Age(action).multiplier+")";
            }
            else if (action is AlphaCurve)
            {
                var ac : AlphaCurve = AlphaCurve(action);
                ret += "var alphaCurve : AlphaCurve = new AlphaCurve("+ac.inLifespan+", "+ac.outLifespan+");\n";
                ret += "alphaCurve.inAlpha = "+ac.inAlpha+";\n";
                ret += "alphaCurve.outAlpha = "+ac.outAlpha+";\n";
                astr = "alphaCurve";
            }
            else if (action is Collide)
            {
                astr = "new Collide()";
            }
            else if (action is Damping)
            {
                astr = "new Damping("+Damping(action).damping+")";
            }
            else if (action is DeathLife)
            {
                astr = "new DeathLife()";
            }
            else if (action is DeathZone)
            {
                istr = "new DeathZone("+parseZone(DeathZone(action).zone)+", "+DeathZone(action).inverted+")";
            }
            else if (action is Move)
            {
                astr = "new Move("+Move(action).multiplier+")";
            }
            else if (action is MutualGravity)
            {
                var mg : MutualGravity = MutualGravity(action);
                ret += "var mutualGravity : MutualGravity = new MutualGravity("+mg.strength+", "+mg.maxDistance+", "+
                                                                                mg.attenuationPower+");\n";
                ret += "mutualGravity.epsilon = "+mg.epsilon+";\n";
                ret += "mutualGravity.massless = "+mg.massless+";\n";
                astr = "mutualGravity";
            }
            else if (action is Oriented)
            {
                astr = "new Oriented( "+Oriented(action).factor+", "+Oriented(action).offset+" )";
            }
            else if (action is RandomDrift)
            {
                var rd : RandomDrift = RandomDrift(action);
                ret += "var randomDrift : RandomDrift = new RandomDrift("+rd.maxX+", "+rd.maxY+", "+
                                                            parseRandom(rd.randomX)+", "+parseRandom(rd.randomY)+");\n";
                ret += "randomDrift.massless = "+rd.massless+";\n";
                astr = "randomDrift";
            }
            else if (action is ScaleCurve)
            {
                var sc : ScaleCurve = ScaleCurve(action);
                ret += "var scaleCurve : ScaleCurve = new ScaleCurve("+sc.inLifespan+", "+sc.outLifespan+");\n";
                ret += "scaleCurve.inScale = "+sc.inScale+";\n";
                ret += "scaleCurve.outScale = "+sc.outScale+";\n";
                astr = "scaleCurve";
            }
            else if (action is SpeedLimit)
            {
                astr = "new SpeedLimit("+SpeedLimit(action).limit+")";
            }
            else if (action is Spin)
            {
                astr = "new Spin("+Spin(action).multiplier+")";
            }
            else if (action is Gravity)
            {
                var grav : Gravity = Gravity(action);
                ret += "var gravity : Gravity = new Gravity();\n";
                for each( var field:Field in grav.fields)
                {
                    ret += "gravity.addField( "+parseField(field)+");\n";
                }
                astr = "gravity";
            }
            else if (action is VelocityField)
            {
                astr = "new VelocityField("+parseField( VelocityField(action).field )+")";
            }
            else if (action is Deflect)
            {
                var def : Deflect = Deflect(action);
                ret += "var deflect : Deflect = new Deflect();\n";
                var cnt:int = 0;
                for each( var deflector:Deflector in def.deflectors)
                {
                    cnt++;
                    const DEFNAME:String = "def"+cnt;
                    ret += "var "+DEFNAME+":Deflector = "+parseDeflector(deflector)+";\n";
                    if ( !(deflector is WrappingBox) )
                    {
                        ret += DEFNAME+".bounce = "+deflector.bounce+";\n";
                    }
                    ret += "deflect.addDeflector("+DEFNAME+");\n";
                }
                astr = "deflect";
            }
            else if (action is FollowWaypoints)
            {
                var fw : FollowWaypoints = FollowWaypoints(action);
                ret += "var followWP : FollowWaypoints = new FollowWaypoints(null,"+fw.loop+", "+fw.massless+");\n";
                cnt = 0;
                for each( var wp:Waypoint in fw.waypoints)
                {
                    cnt++;
                    const WPNAME:String = "waypoint"+cnt;
                    ret += "var "+WPNAME+":Waypoint = new Waypoint("+wp.x+", "+wp.y+", "+wp.radius+", "+
                                                    wp.strength+", "+wp.attenuationPower+", "+wp.epsilon+");\n";
                    ret += "followWP.addWaypoint("+WPNAME+");\n";
                }
                astr = "followWP";
            }
            // TODO: Spawn, Composite
            ret += EMITTERNAME+".addAction( "+astr+" );\n";
        }
        return ret;
    }

    private static function parseDeflector(d:Deflector) : String
    {
        if ( d is CircleDeflector)
        {
            var cd:CircleDeflector = CircleDeflector(d);
            return "new CircleDeflector("+cd.x+", "+cd.y+", "+cd.radius+")";
        }
        else if ( d is LineDeflector)
        {
            var ld:LineDeflector = LineDeflector(d);
            return "new LineDeflector("+ld.x+", "+ld.y+", "+ld.normal.x+", "+ld.normal.y+")";
        }
        else if ( d is WrappingBox)
        {
            var wb:WrappingBox = WrappingBox(d);
            return "new WrappingBox("+wb.x+", "+wb.y+", "+wb.width+", "+wb.height+")";
        }
        return "Cannot parse deflector "+getQualifiedClassName(d);
    }

    private static function parseField(f:Field) : String
    {
        if ( f is RadialField)
        {
            var rf:RadialField = RadialField(f);
            return "new RadialField("+rf.x+", "+rf.y+", "+rf.strength+", "+rf.attenuationPower+", "+rf.epsilon+")";
        }
        else if ( f is UniformField)
        {
            var uf:UniformField = UniformField(f);
            return "new UniformField("+uf.x+", "+uf.y+")";
        }
        return "Cannot parse field "+getQualifiedClassName(f);
    }

    private static function parseClock(c:Clock) : String
    {
        var ret:String = "";
        if (c is SteadyClock)
        {
            ret += "var clock:SteadyClock = new SteadyClock("+SteadyClock(c).ticksPerCall+");\n";
            ret += EMITTERNAME+".clock = clock;\n";
        }
        else if (c is ImpulseClock)
        {
            var ic:ImpulseClock = ImpulseClock(c);
            ret += "// implement burst interval with Timer\n";
            ret += "var clock:ImpulseClock = new ImpulseClock("+ic.impulseCount+", "+ic.repeatCount+");\n";
            ret += EMITTERNAME+".clock = clock;\n";
        }
        return ret;
    }

    private static function parseZone(z:Zone) : String
    {
        if ( z is Line)
        {
            var li:Line = Line(z);
            return "new Line("+li.x1+", "+li.y1+", "+li.x2+", "+li.y2+", "+parseRandom(li.random)+")";
        }
        else if ( z is RectZone)
        {
            var re:RectZone = RectZone(z);
            return "new RectZone("+re.x+", "+re.y+", "+re.width+", "+re.height+", "+re.randomX+", "+re.randomY+")";
        }
        else  if ( z is SinglePoint)
        {
            var sp:SinglePoint = SinglePoint(z);
            return "new SinglePoint("+sp.x+", "+sp.y+")";
        }
        return "Cannot parse zone "+getQualifiedClassName(z);
    }

    private static function parseRandom(r:Random) : String
    {
        if ( r is UniformRandom)
        {
            return "new UniformRandom("+UniformRandom(r).center+", "+UniformRandom(r).radius+")";
        }
        return "Cannot parse random "+getQualifiedClassName(r);
    }
}
}
