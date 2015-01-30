package com.plumbee.stardust.controller
{
import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.SimTimeModel;
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.project.DisplayModes;

import flash.utils.Dictionary;

import org.flexunit.rules.IMethodRule;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.given;
import org.mockito.integrations.verify;

public class UpdateProjectRendererCommandTest extends UpdateProjectRendererCommand
{
	[Rule]
	public var rule : IMethodRule = new MockitoRule();

	[Mock]
	public var timeModel : SimTimeModel;
	[Mock]
	public var emitterVO1 : IBaseEmitter;
	[Mock]
	public var emitterVO2 : IBaseEmitter;
	[Mock]
	public var starlingDelegate : IEmitterRenderingSetup;
	[Mock]
	public var displayListDelegate : IEmitterRenderingSetup;
	[Mock]
	public var projSettings : ProjectModel;
	private var emittersDictionary : Dictionary;

	override protected function getEmitters() : Dictionary
	{
		if (emittersDictionary != null)
		{
			return emittersDictionary;
		}
		return new Dictionary();
	}

	override protected function getDisplayListDelegate() : IEmitterRenderingSetup
	{
		return displayListDelegate;
	}

	override protected function getStarlingDelegate() : IEmitterRenderingSetup
	{
		return starlingDelegate;
	}

	[Before]
	public function setUp() : void
	{
		simTimeModel = timeModel;
		projectSettings = projSettings;
	}

	[Test]
	public function execute_resetTimeModel() : void
	{
		execute();
		verify().that(timeModel.resetTime());
	}

	[Test]
	public function execute_eachEmitterIsReset() : void
	{
		prepareForIterationWithDisplayMode();
		execute();
		for each(var emitter : IBaseEmitter in getEmitters())
		{
			verify().that(emitter.resetEmitter());
		}
	}

	[Test(description="when display mode is starling then updates each emitter to work with starling")]
	public function execute_displayModeStarling_invokesStarlingDelegate() : void
	{
		prepareForIterationWithDisplayMode(DisplayModes.STARLING);
		execute();
		var targetCanvas:* = getRenderCanvas();
		verify().that(starlingDelegate.prepareEmitter(emitterVO1, targetCanvas));
		verify().that(starlingDelegate.prepareEmitter(emitterVO2, targetCanvas));
	}

	[Test(description="when display mode is display list then updates each emitter to work with display list")]
	public function execute_displayModeDL_invokesDLDelegate() : void
	{
		prepareForIterationWithDisplayMode(DisplayModes.DISPLAY_LIST);
		execute();
		var targetCanvas:* = getRenderCanvas();
		verify().that(displayListDelegate.prepareEmitter(emitterVO1, targetCanvas));
		verify().that(displayListDelegate.prepareEmitter(emitterVO2, targetCanvas));
	}

	private function prepareForIterationWithDisplayMode(displayMode : String = DisplayModes.STARLING) : void
	{
		given(projSettings.getDisplayMode()).willReturn(displayMode);
		prepareEmittersDictionaryWith(emitterVO1, emitterVO2);
	}

	private function prepareEmittersDictionaryWith(...emitters) : void
	{
		var count : uint = 0;
		emittersDictionary = new Dictionary();
		for each(var emitter : IBaseEmitter in emitters)
		{
			emittersDictionary[count++] = emitter;
		}
	}


}
}