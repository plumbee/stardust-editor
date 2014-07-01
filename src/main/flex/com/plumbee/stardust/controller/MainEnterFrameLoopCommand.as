package com.plumbee.stardust.controller
{

import com.plumbee.stardust.helpers.Globals;
import com.plumbee.stardust.helpers.ZoneDrawer;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.StardusttoolMainView;
import com.plumbee.stardust.view.events.MainEnterFrameLoopEvent;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.emitter.EmitterValueObject;

import flash.display.BitmapData;

import flash.utils.Dictionary;

import flash.utils.getTimer;

import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

// TODO this needs to be a service, since calcTime needs to be preserved between runs
public class MainEnterFrameLoopCommand implements ICommand
{

    [Inject]
    public var event : MainEnterFrameLoopEvent;

    [Inject]
    public var project : ProjectModel;

    [Inject]
    public var simPlayer : SimPlayer;

    private var calcTime : uint;

    public function execute() : void
    {
        const view : StardusttoolMainView = event.view;
        const startTime : Number = getTimer();
        if ( calcTime > 1000 )
        {
            view.infoLabel.text = "ERROR:Simulation time above 1000ms (" + calcTime + "ms), stopping. Change the sim and restart";
            return;
        }

        if ( project.emitterInFocus.emitter.particleHandler is DisplayObjectHandler )
        {
            simPlayer.stepSimulation();
        }
        else
        {
            const bData : BitmapData = Globals.bitmapData;
            if ( !bData )
            {
                return;
            }
            bData.lock();
            bData.fillRect(bData.rect, 0xFFFFFF);
            simPlayer.stepSimulation();
            bData.unlock();
        }

        calcTime = (getTimer() - startTime);
        view.infoLabel.text = "num particles: " + project.stadustSim.numberOfParticles + " sim time: " + calcTime + "ms";
        if ( view.zonesVisibleCheckBox.selected )
        {
            ZoneDrawer.drawZones();
        }
        else
        {
            view.previewGroup.graphics.clear();
        }
    }
}
}
