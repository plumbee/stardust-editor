package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.SimTimeModel;

import flash.utils.Dictionary;

import org.flexunit.rules.IMethodRule;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.verify;

public class UpdateProjectRendererCommandTest extends UpdateProjectRendererCommand
{
	[Rule]
	public var rule : IMethodRule = new MockitoRule();

	[Mock]
	public var timeModel : SimTimeModel;

	override protected function getEmitters() : Dictionary
	{
		return new Dictionary();
	}

	[Test]
	public function execute_resetTimeModel() : void
	{
		simTimeModel = timeModel;
		execute();
		verify().that(timeModel.resetTime());
	}
}
}
