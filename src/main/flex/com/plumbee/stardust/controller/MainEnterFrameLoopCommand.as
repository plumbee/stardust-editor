package com.plumbee.stardust.controller
{

import com.plumbee.stardust.helpers.Globals;
import com.plumbee.stardust.helpers.ZoneDrawer;
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardust.view.IStardustToolMainView;
import com.plumbee.stardust.view.events.MainEnterFrameLoopEvent;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.SimTimeModel;

import flash.display.BitmapData;
import flash.utils.getTimer;

import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

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

	[Inject]
	public var simTimeModel : SimTimeModel;

	private var calcTime : uint;

	public function execute() : void
	{
		const view : IStardustToolMainView = event.view;
		const startTime : Number = getTimer();
		if (calcTime > 1000)
		{
			view.setInfoText("ERROR:Simulation time above 1000ms (" + calcTime + "ms), stopping. Change the sim and restart");
			return;
		}

		simTimeModel.update();

		if (isParticleHandlerStarlingOrDisplayList())
		{
			simPlayer.stepSimulationWithSubsteps(simTimeModel.timeStep, SimTimeModel.msFor60FPS);
		}
		else
		{
			const bData : BitmapData = Globals.bitmapData;
			if (!bData)
			{
				return;
			}
			bData.lock();
			bData.fillRect(bData.rect, 0xFFFFFF);

			simPlayer.stepSimulationWithSubsteps(simTimeModel.timeStep, SimTimeModel.msFor60FPS);

			bData.unlock();
		}

		updateParticleLabelInformation(startTime, view);

		drawZonesIfNeeded(view);
	}

	private function drawZonesIfNeeded(view : IStardustToolMainView) : void
	{
		if (view.areZonesVisible())
		{
			ZoneDrawer.drawZones();
		}
		else
		{
			view.clearPreview();
		}
	}

	private function updateParticleLabelInformation(startTime : Number, view : IStardustToolMainView) : void
	{
		calcTime = (getTimer() - startTime);
		view.setInfoText("num particles: " + getParticlesAmount() + " sim time: " + calcTime + "ms");
	}

	protected function getParticlesAmount() : uint
	{
		return project.stadustSim.numberOfParticles;
	}

	protected function isParticleHandlerStarlingOrDisplayList() : Boolean
	{
		return project.emitterInFocus.emitter.particleHandler is DisplayObjectHandler || project.emitterInFocus.emitter.particleHandler is StarlingHandler;
	}
}
}
