package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
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
	[Mock]
	public var invalidEmitter : IBaseEmitter;

	private var setup : EmitterRenderingSetupDisplayList;


	[Before]
	public function setUp() : void
	{
		setup = new EmitterRenderingSetupDisplayList();
	}

	[Test(expects="TypeError", description="throws error if emitter type is not handled")]
	public function throwsError_ifNotDLEmitter() : void
	{
		setup.prepareEmitter(invalidEmitter, new Sprite());
	}

	[Test(expects="TypeError",description="throws error if canvas type is not handled")]
	public function throwsError_ifNotDisplayObjContainerCanvas() : void
	{
		setup.prepareEmitter(emitter, new Object());
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
		var target:DisplayObjectContainer = new Sprite();
		setup.prepareEmitter(emitter, target);
		verify().that(emitter.updateHandlerCanvas(target));
	}


	[Test]
	public function prepare_removesRendererDependencies() : void
	{
		setup.prepareEmitter(emitter, new Sprite());
		verify().that(emitter.removeRendererSpecificInitializers());
	}
}
}
