package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IDisplayListEmitter;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;

import org.flexunit.rules.IMethodRule;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.verify;

public class EmitterRenderingSetupDisplayListTest
{
	[Rule]
	public var rule : IMethodRule = new MockitoRule();
	[Mock]
	public var emitter : IDisplayListEmitter;

	private var setup : EmitterRenderingSetupDisplayList;


	[Before]
	public function setUp() : void
	{
		setup = new EmitterRenderingSetupDisplayList();
	}

	[Test]
	public function prepare_addsDisplayListInitializers() : void
	{
		setup.prepareEmitter(emitter, new Sprite());
		verify().that(emitter.addDisplayListInitializers());
	}

	[Test]
	public function prepare_updatesHandlerCanvas() : void
	{
		var target : DisplayObjectContainer = new Sprite();
		setup.prepareEmitter(emitter, target);
		verify().that(emitter.updateHandlerCanvas(target));
	}
}
}
