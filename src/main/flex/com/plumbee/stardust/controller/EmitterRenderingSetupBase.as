package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;

public class EmitterRenderingSetupBase implements IEmitterRenderingSetup
{
	protected var emitterType : Class;

	protected var canvasType : Class;

	final public function prepareEmitter(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		checkTypeCompliance(emitter, targetRenderCanvas);
		emitter.removeRendererSpecificInitializers();
		doPrepareEmitterTemplate(emitter, targetRenderCanvas);
	}

	final protected function checkTypeCompliance(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		if (!(targetRenderCanvas is canvasType))
		{
			throw(new TypeError("invalid canvas type"));
		}
		if (!(emitter is emitterType))
		{
			throw(new TypeError("invalid emitter type"));
		}
	}

	protected function doPrepareEmitterTemplate(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		throw(new Error("Abstract"));
	}
}
}
