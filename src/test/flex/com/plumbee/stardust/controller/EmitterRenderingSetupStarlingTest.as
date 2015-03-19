package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.emitter.IStarlingEmitter;
import com.plumbee.stardustplayer.emitter.StarlingEmitterValueObject;

import idv.cjcat.stardustextended.twoD.emitters.Emitter2D;

import org.flexunit.rules.IMethodRule;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.given;
import org.mockito.integrations.verify;

import starling.display.DisplayObjectContainer;
import starling.display.Sprite;

public class EmitterRenderingSetupStarlingTest
{
	[Rule]
	public var rule : IMethodRule = new MockitoRule();

	private const emitter2d: Emitter2D = new Emitter2D();
	public const emitterArgs:Array = [0,emitter2d];

	[Mock(argsList="emitterArgs")]
	public var emitter : StarlingEmitterValueObject;


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
}
}
