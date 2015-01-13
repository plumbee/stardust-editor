package com.plumbee.stardust.controller
{
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.SimTimeModel;
import com.plumbee.stardustplayer.project.ProjectValueObject;

import flash.events.EventDispatcher;

import org.flexunit.rules.IMethodRule;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.verify;

public class StartSimCommandTest extends StartSimCommand
{

	[Rule]
	public var rule : IMethodRule = new MockitoRule();

	[Mock]
	public var timeModel : SimTimeModel;

	[Mock]
	public var player : SimPlayer;

	[Mock]
	public var settings : ProjectModel;

	[Mock]
	public var stardustSim : ProjectValueObject;

	override protected function getEmitterInFocusSmoothing() : Boolean
	{
		return true;
	}

	override protected function emitterInFocusHasDisplayObjectHandler() : Boolean
	{
		return false;
	}

	override protected function getEmitterInFocusBlendMode() : String
	{
		return "whatever";
	}

	[Test]
	public function execute_resetsTimeModel() : void
	{
		settings.stadustSim = stardustSim;
		simTimeModel = timeModel;
		simPlayer = player;
		projectSettings = settings;
		dispatcher = new EventDispatcher();
		execute();
		verify().that(timeModel.resetTime());
	}
}
}
