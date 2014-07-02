package com.plumbee.stardust.controller
{

import com.plumbee.stardust.controller.events.ChangeEmitterInFocusEvent;
import com.plumbee.stardust.controller.events.StartSimEvent;
import com.plumbee.stardust.helpers.Globals;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.emitter.EmitterBuilder;
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import flash.display.BitmapData;

import flash.events.IEventDispatcher;

import idv.cjcat.stardustextended.sd;
import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

use namespace sd;

public class AddEmitterCommand implements ICommand
{

    [Inject]
    public var simPlayer : SimPlayer;

    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var dispatcher : IEventDispatcher;

    private static const DEFAULT_EMITTER : XML =
    <StardustParticleSystem version="2">
        <actions>
            <Age name="Age_0" active="true" mask="1" multiplier="1"/>
            <AnimateSpriteSheet name="AnimateSpriteSheet_0" active="true" mask="1"/>
            <DeathLife name="DeathLife_0" active="true" mask="1"/>
            <Move name="Move_0" active="true" mask="1" multiplier="1"/>
        </actions>
        <clocks>
            <SteadyClock name="SteadyClock_6" ticksPerCall="1"/>
        </clocks>
        <emitters>
            <Emitter2D name="Default" active="true" clock="SteadyClock_6" particleHandler="DisplayObjectHandler_2">
                <actions>
                    <AnimateSpriteSheet name="AnimateSpriteSheet_0"/>
                    <DeathLife name="DeathLife_0"/>
                    <Age name="Age_0"/>
                    <Move name="Move_0"/>
                </actions>
                <initializers>
                    <PooledDisplayObjectClass name="PooledDisplayObjectClass_0"/>
                    <BitmapParticleInit name="BitmapParticleInit_0"/>
                    <PositionAnimated name="PositionAnimated_0"/>
                    <Velocity name="Velocity_0"/>
                    <Life name="Life_0"/>
                </initializers>
            </Emitter2D>
        </emitters>
        <handlers>
            <DisplayObjectHandler name="DisplayObjectHandler_2" addChildMode="0" forceParentChange="false" blendMode="normal"/>
        </handlers>
        <initializers>
            <BitmapParticleInit name="BitmapParticleInit_0" active="true" bitmapType="singleImage" spriteSheetSliceWidth="0" spriteSheetSliceHeight="0" spriteSheetAnimationSpeed="0" spriteSheetStartAtRandomFrame="false" smoothing="false"/>
            <Life name="Life_0" active="true" random="UniformRandom_1"/>
            <PooledDisplayObjectClass name="PooledDisplayObjectClass_0" active="true" displayObjectClass="idv.cjcat.stardustextended.twoD.display.bitmapParticle::BitmapParticle"/>
            <PositionAnimated name="PositionAnimated_0" active="true" zone="Line_0" inheritVelocity="false"/>
            <Velocity name="Velocity_0" active="true" zone="SinglePoint_0"/>
        </initializers>
        <randoms>
            <UniformRandom name="UniformRandom_1" center="200" radius="50"/>
        </randoms>
        <zones>
            <Line name="Line_0" rotation="0" virtualThickness="1" x1="10" y1="10" x2="300" y2="10"/>
            <SinglePoint name="SinglePoint_0" rotation="0" virtualThickness="1" x="0" y="2"/>
        </zones>
    </StardustParticleSystem>;

    public function execute() : void
    {
        var uniqueID : uint = 0;
        while ( projectSettings.stadustSim.emitters[uniqueID] )
        {
            uniqueID++;
        }
        const emitterData : EmitterValueObject = new EmitterValueObject( uniqueID );
        emitterData.emitter = EmitterBuilder.buildEmitter( DEFAULT_EMITTER );
        emitterData.image = new BitmapData( 10, 10, false, Math.random()*16777215 );
        emitterData.emitter.name = emitterData.imageName;

        if (projectSettings.stadustSim.emitters[emitterData.id])
        {
            throw new Error("Emitter with ID" + emitterData.id + "already exists!");
        }
        projectSettings.stadustSim.emitters[emitterData.id] = emitterData;

        //set the simulation for the new emitter
        if (emitterData.emitter.particleHandler is DisplayObjectHandler)
        {
            simPlayer.setSimulation( projectSettings.stadustSim, Globals.canvas);
        }
        else
        {
            simPlayer.setSimulation( projectSettings.stadustSim, Globals.bitmapData);
        }

        // display data for the new emitter
        dispatcher.dispatchEvent( new ChangeEmitterInFocusEvent( ChangeEmitterInFocusEvent.CHANGE, emitterData ) );

        dispatcher.dispatchEvent( new StartSimEvent() );
    }

}
}
