package helpers
{
import view.stardust.twoD.actions.AccelerateAction;
import view.stardust.twoD.actions.AgeAction;
import view.stardust.twoD.actions.AlphaCurveAction;
import view.stardust.twoD.actions.CollideAction;
import view.stardust.twoD.actions.CompositeActionAction;
import view.stardust.twoD.actions.DampingAction;
import view.stardust.twoD.actions.DeathLifeAction;
import view.stardust.twoD.actions.DeathTriggerAction;
import view.stardust.twoD.actions.DeathZoneAction;
import view.stardust.twoD.actions.DeflectAction;
import view.stardust.twoD.actions.FollowWaypointsAction;
import view.stardust.twoD.actions.GravityAction;
import view.stardust.twoD.actions.MoveAction;
import view.stardust.twoD.actions.MutualGravityAction;
import view.stardust.twoD.actions.NormalDriftAction;
import view.stardust.twoD.actions.OrientedAction;
import view.stardust.twoD.actions.RandomDriftAction;
import view.stardust.twoD.actions.ScaleCurveAction;
import view.stardust.twoD.actions.SpeedLimitAction;
import view.stardust.twoD.actions.SpinAction;
import view.stardust.twoD.actions.VelocityFieldAction;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.BlendMode;

import flash.utils.Dictionary;

import idv.cjcat.stardust.common.actions.Age;
import idv.cjcat.stardust.common.actions.AlphaCurve;
import idv.cjcat.stardust.common.actions.CompositeAction;
import idv.cjcat.stardust.common.actions.DeathLife;
import idv.cjcat.stardust.common.actions.ScaleCurve;
import idv.cjcat.stardust.common.actions.triggers.DeathTrigger;

import idv.cjcat.stardust.common.initializers.Alpha;
import idv.cjcat.stardust.common.initializers.CollisionRadius;

import idv.cjcat.stardust.common.initializers.Life;
import idv.cjcat.stardust.common.initializers.Mask;
import idv.cjcat.stardust.common.initializers.Mass;
import idv.cjcat.stardust.common.initializers.Scale;
import idv.cjcat.stardust.twoD.actions.Accelerate;
import idv.cjcat.stardust.twoD.actions.Collide;
import idv.cjcat.stardust.twoD.actions.Damping;
import idv.cjcat.stardust.twoD.actions.DeathZone;
import idv.cjcat.stardust.twoD.actions.Deflect;
import idv.cjcat.stardust.twoD.actions.FollowWaypoints;
import idv.cjcat.stardust.twoD.actions.Gravity;
import idv.cjcat.stardust.twoD.actions.Move;
import idv.cjcat.stardust.twoD.actions.MutualGravity;
import idv.cjcat.stardust.twoD.actions.NormalDrift;
import idv.cjcat.stardust.twoD.actions.Oriented;
import idv.cjcat.stardust.twoD.actions.RandomDrift;
import idv.cjcat.stardust.twoD.actions.SpeedLimit;
import idv.cjcat.stardust.twoD.actions.Spin;
import idv.cjcat.stardust.twoD.actions.VelocityField;

import idv.cjcat.stardust.twoD.initializers.DisplayObjectClass;
import idv.cjcat.stardust.twoD.initializers.Omega;
import idv.cjcat.stardust.twoD.initializers.PooledDisplayObjectClass;
import idv.cjcat.stardust.twoD.initializers.Position;
import idv.cjcat.stardust.twoD.initializers.Velocity;

import view.stardust.twoD.initializers.AlphaInitalizer;
import view.stardust.twoD.initializers.CollisionRadiusInitalizer;

import view.stardust.twoD.initializers.DisplayObjectClassInitalizer;
import view.stardust.twoD.initializers.LifeInitalizer;
import view.stardust.twoD.initializers.MaskInitializer;
import view.stardust.twoD.initializers.MassInitializer;
import view.stardust.twoD.initializers.OmegaInitalizer;
import view.stardust.twoD.initializers.PositionInitalizer;
import view.stardust.twoD.initializers.ScaleInitalizer;
import view.stardust.twoD.initializers.VelocityInitalizer;

import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;

public class Globals
{

    public static const initalizerDict:Dictionary = new Dictionary();
    public static const actionDict:Dictionary = new Dictionary();
    public static const initializerDDLAC:ArrayCollection = new ArrayCollection();
    public static const actionsDDLAC:ArrayCollection = new ArrayCollection();
    public static const blendModes:ArrayCollection = new ArrayCollection([
        BlendMode.NORMAL,
        BlendMode.LAYER,
        BlendMode.MULTIPLY,
        BlendMode.SCREEN,
        BlendMode.LIGHTEN,
        BlendMode.DARKEN,
        BlendMode.ADD,
        BlendMode.SUBTRACT,
        BlendMode.DIFFERENCE,
        BlendMode.INVERT,
        BlendMode.OVERLAY,
        BlendMode.HARDLIGHT,
        BlendMode.ALPHA,
        BlendMode.ERASE
    ]);

    // used by particle handlers
    public static var bitmapData:BitmapData;

    public static function init():void
    {
        initalizerDict[ PooledDisplayObjectClass ] = new DropdownListVO("Graphic asset", PooledDisplayObjectClass, DisplayObjectClassInitalizer);
        initalizerDict[ Position ] = new DropdownListVO("Position", Position, PositionInitalizer);
        initalizerDict[ Velocity ] = new DropdownListVO("Velocity", Velocity, VelocityInitalizer);
        initalizerDict[ Life ] = new DropdownListVO("Life", Life, LifeInitalizer);
        initalizerDict[ Alpha ] = new DropdownListVO("Alpha", Alpha, AlphaInitalizer);
        initalizerDict[ Scale ] = new DropdownListVO("Scale", Scale, ScaleInitalizer);
        initalizerDict[ Omega ] = new DropdownListVO("Angular velocity", Omega, OmegaInitalizer);
        initalizerDict[ Mass ] = new DropdownListVO("Mass", Mass, MassInitializer);
        initalizerDict[ CollisionRadius ] = new DropdownListVO("Collision radius", CollisionRadius, CollisionRadiusInitalizer);
        //initalizerDict[ Mask ] = new DropdownListVO("Mask", Mask, MaskInitializer);

        actionDict[ Move ] = new DropdownListVO("Simulation speed", Move, MoveAction);
        actionDict[ DeathZone ] = new DropdownListVO("Death zone", DeathZone, DeathZoneAction);
        actionDict[ RandomDrift ] = new DropdownListVO("Random acceleration", RandomDrift, RandomDriftAction);
        actionDict[ Oriented ] = new DropdownListVO("Orient to velocity", Oriented, OrientedAction);
        actionDict[ Age ] = new DropdownListVO("Change age", Age, AgeAction);
        actionDict[ DeathLife ] = new DropdownListVO("Death on life end", DeathLife, DeathLifeAction);
        actionDict[ AlphaCurve ] = new DropdownListVO("Change alpha", AlphaCurve, AlphaCurveAction);
        actionDict[ ScaleCurve ] = new DropdownListVO("Change scale", ScaleCurve, ScaleCurveAction);
        actionDict[ Accelerate ] = new DropdownListVO("Accelerate", Accelerate, AccelerateAction);
        actionDict[ Damping ] = new DropdownListVO("Damping", Damping, DampingAction);
        actionDict[ SpeedLimit ] = new DropdownListVO("Speed limit", SpeedLimit, SpeedLimitAction);
        actionDict[ Spin ] = new DropdownListVO("Spin", Spin, SpinAction);
        actionDict[ FollowWaypoints ] = new DropdownListVO("Follow waypoints", FollowWaypoints, FollowWaypointsAction);
        actionDict[ Deflect ] = new DropdownListVO("Deflect/bounce", Deflect, DeflectAction);
        actionDict[ Gravity ] = new DropdownListVO("Gravity (acceleration) field", Gravity, GravityAction);
        actionDict[ VelocityField ] = new DropdownListVO("Velocity field", VelocityField, VelocityFieldAction);
        actionDict[ NormalDrift ] = new DropdownListVO("Perpendicular acceleration", NormalDrift, NormalDriftAction);
        //actionDict[ DeathTrigger ] = new DropdownListVO("Spawn particles", DeathTrigger, DeathTriggerAction);
        //actionDict[ CompositeAction ] = new DropdownListVO("Action group", CompositeAction, CompositeActionAction);
        actionDict[ MutualGravity ] = new DropdownListVO("Mutual gravity (CPU intensive)", MutualGravity, MutualGravityAction);
        actionDict[ Collide ] = new DropdownListVO("Collide (CPU intensive)", Collide, CollideAction);

        for each (var ddlVO2:DropdownListVO in initalizerDict)
        {
            initializerDDLAC.addItem(ddlVO2);
        }
        var sort:Sort = new Sort();
        sort.fields = [new SortField("name", true)];
        initializerDDLAC.sort = sort;
        initializerDDLAC.refresh();
        for each (var ddlVO:DropdownListVO in actionDict)
        {
            actionsDDLAC.addItem(ddlVO);
        }
        actionsDDLAC.sort = sort;
        actionsDDLAC.refresh();
    }

    public static function stringToBitwiseOR( str:String ) : int
    {
        str = str.replace(" ", "");
        var arr : Array = str.split(",");
        if ( arr.length == 0 )
        {
            return 0;
        }
        var ret : int = arr[0];
        for ( var i:int = 1; i < arr.length; i++ )
        {
            ret = ret | parseInt(arr[i]);
        }
        return ret;
    }
}
}
