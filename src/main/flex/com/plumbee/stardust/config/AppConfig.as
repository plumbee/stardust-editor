package com.plumbee.stardust.config
{

import com.plumbee.stardust.controller.AddEmitterCommand;
import com.plumbee.stardust.controller.ChangeEmitterInFocusCommand;
import com.plumbee.stardust.controller.EmitterNameChangeCommand;
import com.plumbee.stardust.controller.FileLoadCommand;
import com.plumbee.stardust.controller.ImpulseClockRendererUpdateEmitterInfoCommand;
import com.plumbee.stardust.controller.InitializeZoneDrawerFromEmitterCommand;
import com.plumbee.stardust.controller.ChangeBackgroundCommand;
import com.plumbee.stardust.controller.LoadEmitterImageFromFileReferenceCommand;
import com.plumbee.stardust.controller.LoadEmitterPathCommand;
import com.plumbee.stardust.controller.LoadSimCommand;
import com.plumbee.stardust.controller.MainEnterFrameLoopCommand;
import com.plumbee.stardust.controller.OnActionACAddCommand;
import com.plumbee.stardust.controller.OnActionACRemoveCommand;
import com.plumbee.stardust.controller.OnInitializerACAddCommand;
import com.plumbee.stardust.controller.OnInitializerACRemoveCommand;
import com.plumbee.stardust.controller.RemoveEmitterCommand;
import com.plumbee.stardust.controller.SaveSimCommand;
import com.plumbee.stardust.controller.SetEmitterInFocusClockTypeToImpulseCommand;
import com.plumbee.stardust.controller.SetEmitterInFocusClockTypeToSteadyCommand;
import com.plumbee.stardust.controller.StartSimCommand;
import com.plumbee.stardust.controller.StartToolCommand;
import com.plumbee.stardust.controller.UpdateBlendModeCommand;
import com.plumbee.stardust.controller.UpdateClockInEmitterGroupCommand;
import com.plumbee.stardust.controller.UpdateClockValuesFromModelCommand;
import com.plumbee.stardust.controller.UpdateDisplayModeCommand;
import com.plumbee.stardust.controller.UpdateEmitterDropDownListCommand;
import com.plumbee.stardust.controller.UpdateEmitterInfoTicksPerCallCommand;
import com.plumbee.stardust.controller.UpdateSmoothingCommand;
import com.plumbee.stardust.controller.events.BackgroundChangeEvent;
import com.plumbee.stardust.controller.events.ChangeEmitterInFocusEvent;
import com.plumbee.stardust.controller.events.EmitterChangeEvent;
import com.plumbee.stardust.controller.events.FileLoadEvent;
import com.plumbee.stardust.controller.events.LoadSimEvent;
import com.plumbee.stardust.controller.events.SaveSimEvent;
import com.plumbee.stardust.controller.events.StartSimEvent;
import com.plumbee.stardust.controller.events.StartToolEvent;
import com.plumbee.stardust.controller.events.UpdateClockValuesFromModelEvent;
import com.plumbee.stardust.controller.events.UpdateDisplayModeEvent;
import com.plumbee.stardust.controller.events.UpdateEmitterDropDownListEvent;
import com.plumbee.stardust.view.events.UpdateSmoothingEvent;
import com.plumbee.stardustplayer.ISimLoader;
import com.plumbee.stardustplayer.SimLoader;
import com.plumbee.stardust.view.BackgroundProvider;
import com.plumbee.stardust.view.EmittersUIView;
import com.plumbee.stardust.view.ParticleHandlerContainer;
import com.plumbee.stardust.view.StardusttoolMainView;
import com.plumbee.stardust.view.events.ClockTypeChangeEvent;
import com.plumbee.stardust.view.events.EmitterNameChangeEvent;
import com.plumbee.stardust.view.events.ImpulseClockRendererUpdateEmitterInfoEvent;
import com.plumbee.stardust.view.events.InitializeZoneDrawerFromEmitterGroupEvent;
import com.plumbee.stardust.view.events.LoadEmitterImageFromFileReferenceEvent;
import com.plumbee.stardust.view.events.MainEnterFrameLoopEvent;
import com.plumbee.stardust.view.events.OnActionACChangeEvent;
import com.plumbee.stardust.view.events.OnInitializerACChangeEvent;
import com.plumbee.stardust.view.events.PositionInitializerEmitterPathEvent;
import com.plumbee.stardust.view.events.UpdateBlendModeEvent;
import com.plumbee.stardust.view.events.UpdateClockInEmitterGroupEvent;
import com.plumbee.stardust.view.events.UpdateEmitterInfoTicksPerCallEvent;
import com.plumbee.stardust.view.mediators.BackgroundProviderMediator;
import com.plumbee.stardust.view.mediators.ClockContainerMediator;
import com.plumbee.stardust.view.mediators.BitmapParticleInitializerMediator;
import com.plumbee.stardust.view.mediators.EmittersUIViewMediator;
import com.plumbee.stardust.view.mediators.ImpulseClockRendererMediator;
import com.plumbee.stardust.view.mediators.ParticleHandlerContainerMediator;
import com.plumbee.stardust.view.mediators.PositionInitializerMediator;
import com.plumbee.stardust.view.mediators.StardusttoolMainViewMediator;
import com.plumbee.stardust.view.mediators.SteadyClockRendererMediator;
import com.plumbee.stardust.view.stardust.common.clocks.ClockContainer;
import com.plumbee.stardust.view.stardust.common.clocks.ImpulseClockRenderer;
import com.plumbee.stardust.view.stardust.common.clocks.SteadyClockRenderer;
import com.plumbee.stardust.view.stardust.twoD.initializers.BitmapParticleInitalizer;
import com.plumbee.stardust.view.stardust.twoD.initializers.PositionInitializer;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.sequenceLoader.ISequenceLoader;
import com.plumbee.stardustplayer.sequenceLoader.SequenceLoader;

import flash.events.IEventDispatcher;

import mx.core.IVisualElementContainer;

import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IInjector;

public class AppConfig implements IConfig
{
    [Inject]
    public var injector : IInjector;

    [Inject]
    public var context : IContext;

    [Inject]
    public var eventCommandMap : IEventCommandMap;

    [Inject]
    public var mediatorMap : IMediatorMap;

    [Inject]
    public var dispatcher : IEventDispatcher;

    [Inject]
    public var contextView : ContextView;

    public function configure() : void
    {
        mediatorMap.map( StardusttoolMainView ).toMediator( StardusttoolMainViewMediator );
        mediatorMap.map( SteadyClockRenderer ).toMediator( SteadyClockRendererMediator );
        mediatorMap.map( BackgroundProvider ).toMediator( BackgroundProviderMediator );
        mediatorMap.map( ParticleHandlerContainer ).toMediator( ParticleHandlerContainerMediator );
        mediatorMap.map( BitmapParticleInitalizer ).toMediator( BitmapParticleInitializerMediator );
        mediatorMap.map( EmittersUIView ).toMediator( EmittersUIViewMediator );
        mediatorMap.map( ImpulseClockRenderer ).toMediator( ImpulseClockRendererMediator );
        mediatorMap.map( PositionInitializer ).toMediator( PositionInitializerMediator );
        mediatorMap.map( ClockContainer ).toMediator( ClockContainerMediator );

        eventCommandMap.map( StartToolEvent.START_TOOL ).toCommand( StartToolCommand );
        eventCommandMap.map( StartSimEvent.START ).toCommand( StartSimCommand );
        eventCommandMap.map( UpdateEmitterInfoTicksPerCallEvent.UPDATE ).toCommand( UpdateEmitterInfoTicksPerCallCommand );
        eventCommandMap.map( UpdateDisplayModeEvent.UPDATE, UpdateDisplayModeEvent ).toCommand( UpdateDisplayModeCommand );
        eventCommandMap.map( UpdateBlendModeEvent.UPDATE ).toCommand( UpdateBlendModeCommand );
        eventCommandMap.map( UpdateSmoothingEvent.UPDATE ).toCommand( UpdateSmoothingCommand );
        eventCommandMap.map( EmitterChangeEvent.ADD ).toCommand( AddEmitterCommand );
        eventCommandMap.map( EmitterChangeEvent.REMOVE ).toCommand( RemoveEmitterCommand );
        eventCommandMap.map( ChangeEmitterInFocusEvent.CHANGE ).toCommand( ChangeEmitterInFocusCommand );
        eventCommandMap.map( UpdateEmitterDropDownListEvent.UPDATE ).toCommand( UpdateEmitterDropDownListCommand );
        eventCommandMap.map( EmitterNameChangeEvent.CHANGE ).toCommand( EmitterNameChangeCommand );
        eventCommandMap.map( UpdateClockInEmitterGroupEvent.UPDATE ).toCommand( UpdateClockInEmitterGroupCommand );
        eventCommandMap.map( ImpulseClockRendererUpdateEmitterInfoEvent.UPDATE ).toCommand( ImpulseClockRendererUpdateEmitterInfoCommand );
        eventCommandMap.map( OnActionACChangeEvent.ADD ).toCommand( OnActionACAddCommand );
        eventCommandMap.map( OnActionACChangeEvent.REMOVE ).toCommand( OnActionACRemoveCommand );
        eventCommandMap.map( OnInitializerACChangeEvent.ADD ).toCommand( OnInitializerACAddCommand );
        eventCommandMap.map( OnInitializerACChangeEvent.REMOVE ).toCommand( OnInitializerACRemoveCommand );
        eventCommandMap.map( LoadEmitterImageFromFileReferenceEvent.LOAD ).toCommand( LoadEmitterImageFromFileReferenceCommand );
        eventCommandMap.map( SaveSimEvent.SAVE ).toCommand( SaveSimCommand );
        eventCommandMap.map( LoadSimEvent.LOAD ).toCommand( LoadSimCommand );
        eventCommandMap.map( FileLoadEvent.LOAD ).toCommand( FileLoadCommand );
        eventCommandMap.map( BackgroundChangeEvent.TYPE ).toCommand( ChangeBackgroundCommand );
        eventCommandMap.map( PositionInitializerEmitterPathEvent.LOAD ).toCommand( LoadEmitterPathCommand );
        eventCommandMap.map( UpdateClockValuesFromModelEvent.UPDATE ).toCommand( UpdateClockValuesFromModelCommand );
        eventCommandMap.map( ClockTypeChangeEvent.IMPULSE_CLOCK, ClockTypeChangeEvent ).toCommand( SetEmitterInFocusClockTypeToImpulseCommand );
        eventCommandMap.map( ClockTypeChangeEvent.STEADY_CLOCK, ClockTypeChangeEvent ).toCommand( SetEmitterInFocusClockTypeToSteadyCommand );
        eventCommandMap.map( InitializeZoneDrawerFromEmitterGroupEvent.INITIALIZE, InitializeZoneDrawerFromEmitterGroupEvent ).toCommand( InitializeZoneDrawerFromEmitterCommand );
        eventCommandMap.map( MainEnterFrameLoopEvent.ENTER_FRAME, MainEnterFrameLoopEvent ).toCommand( MainEnterFrameLoopCommand );
        injector.map( ProjectModel ).asSingleton();
        injector.map( ISequenceLoader ).toSingleton( SequenceLoader );
        injector.map( ISimLoader ).toSingleton( SimLoader );
        injector.map(SimPlayer).asSingleton();

        context.afterInitializing( init );
    }

    public function init() : void
    {
        //The StartToolEvent is called in the StardusttoolMainView
        IVisualElementContainer( contextView.view ).addElement( new StardusttoolMainView() );

        dispatcher.dispatchEvent( new StartToolEvent() );
    }
}
}
