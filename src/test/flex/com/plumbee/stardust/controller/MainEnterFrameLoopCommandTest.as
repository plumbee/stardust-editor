package com.plumbee.stardust.controller
{
import com.plumbee.stardust.view.IStardustToolMainView;
import com.plumbee.stardust.view.events.MainEnterFrameLoopEvent;
import com.plumbee.stardustplayer.SimPlayer;
import com.plumbee.stardustplayer.SimTimeModel;

import org.flexunit.rules.IMethodRule;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.verify;

public class MainEnterFrameLoopCommandTest extends MainEnterFrameLoopCommand
{
	[Rule]
	public var rule : IMethodRule = new MockitoRule();

	[Mock]
	public var timeModel : SimTimeModel;

	[Mock]
	public var view : IStardustToolMainView;

	[Mock]
	public var player:SimPlayer;

	private var particleHandlerIsStarlingOrDisplayList : Boolean = true;

	[Before]
	public function setUp() : void
	{
		simPlayer = player;
		event = new MainEnterFrameLoopEvent(MainEnterFrameLoopEvent.ENTER_FRAME, view);
		simTimeModel = timeModel;
	}

	[Test]
	public function execute_updatesTimeModel() : void
	{
		execute();
		verify().that(timeModel.update());
	}

	[Test(description="when handler is displaylist or starling, execute will step simulation with timemodel frame time")]
	public function execute_notBitmapHandler_stepsWithSubsteps() : void
	{
		particleHandlerIsStarlingOrDisplayList = true;
		execute();
		verify().that(simPlayer.stepSimulationWithSubsteps(simTimeModel.timeStep,SimTimeModel.msFor60FPS));
	}

	override protected function isParticleHandlerStarlingOrDisplayList() : Boolean
	{
		return particleHandlerIsStarlingOrDisplayList;
	}


	override protected function getParticlesAmount() : uint
	{
		return 0;
	}
}
}
