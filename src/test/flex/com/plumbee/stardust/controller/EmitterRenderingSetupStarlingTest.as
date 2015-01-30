package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.emitter.IStarlingEmitter;

import org.flexunit.rules.IMethodRule;
import org.mockito.integrations.any;
import org.mockito.integrations.anyOf;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.verify;

import starling.display.DisplayObjectContainer;

import starling.display.Sprite;
import starling.textures.Texture;

public class EmitterRenderingSetupStarlingTest
{

	[Rule]
	public var rule : IMethodRule = new MockitoRule();
	[Mock]
	public var emitter : IStarlingEmitter;
	[Mock]
	public var invalidEmitter : IBaseEmitter;

	private var setup : EmitterRenderingSetupStarling;


	[Before]
	public function setUp() : void
	{
		setup = new EmitterRenderingSetupStarling();
	}

	[Test]
	public function prepare_updatesHandlerCanvas() : void
	{
		var target : DisplayObjectContainer = new Sprite();
		setup.prepareEmitter(emitter, target);
		verify().that(emitter.updateHandlerCanvas(target));
	}

	[Test]
	public function prepare_addsStarlingInitializers() : void
	{
		setup.prepareEmitter(emitter, new Sprite());
		verify().that(emitter.addStarlingInitializers(any()));
	}
}
}
