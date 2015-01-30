package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;

import org.flexunit.assertThat;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.rules.IMethodRule;
import org.hamcrest.core.isA;
import org.mockito.integrations.flexunit4.MockitoRule;
import org.mockito.integrations.verify;

public class EmitterRenderingSetupBaseTest extends EmitterRenderingSetupBase
{
	[Rule]
	public var rule : IMethodRule = new MockitoRule();
	[Mock]
	public var emitter : IBaseEmitter;

	override protected function doPrepareEmitterTemplate(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		assertNotNull(emitter);
		assertThat(emitter, isA(emitterType));
		assertNotNull(targetRenderCanvas);
		assertThat(targetRenderCanvas, isA(canvasType));
	}

	[Before]
	public function setUp() : void
	{
		emitterType = ValidEmitter;
		canvasType = ValidCanvasType;
	}

	[Test(expects="TypeError", description="throws error if canvas type is not handled")]
	public function throwsError_ifNotValidCanvas() : void
	{
		checkTypeCompliance(new ValidEmitter(), new Object());
	}

	[Test(expects="TypeError", description="throws error if emitter type is not handled")]
	public function throwsError_ifNotValidEmitter() : void
	{
		checkTypeCompliance(new InvalidEmitter(), new ValidCanvasType());
	}

	[Test]
	public function noErrorExpected_ifValidEmitterAndCanvas() : void
	{
		checkTypeCompliance(new ValidEmitter(), new ValidCanvasType());
	}


	[Test(expects="TypeError")]
	public function prepare_checksCompliance() : void
	{
		prepareEmitter(emitter,null);
	}

	[Test]
	public function prepare_removesRendererDependencies() : void
	{
		emitterType = IBaseEmitter;
		prepareEmitter(emitter, new ValidCanvasType());
		verify().that(emitter.removeRendererSpecificInitializers());
	}

	[Test]
	public function prepare_callsActualImplementationWithValidParams() : void
	{
		prepareEmitter(new ValidEmitter(), new ValidCanvasType());
	}
}
}

import com.plumbee.stardustplayer.emitter.IBaseEmitter;

class ValidEmitter implements IBaseEmitter
{

	public function destroy() : void
	{
	}

	public function resetEmitter() : void
	{
	}

	public function get id() : uint
	{
		return 0;
	}

	public function removeRendererSpecificInitializers() : void
	{
	}
}

class InvalidEmitter implements IBaseEmitter
{

	public function destroy() : void
	{
	}

	public function resetEmitter() : void
	{
	}

	public function get id() : uint
	{
		return 0;
	}

	public function removeRendererSpecificInitializers() : void
	{
	}
}

class ValidCanvasType
{
}