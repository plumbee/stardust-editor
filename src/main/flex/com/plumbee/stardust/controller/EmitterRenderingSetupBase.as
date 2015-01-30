package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
import com.plumbee.stardustplayer.emitter.IBaseEmitter;

import idv.cjcat.stardustextended.common.utils.construct;

public class EmitterRenderingSetupBase implements IEmitterRenderingSetup
{
	protected var emitterType : Class;

	protected var canvasType : Class;

	final public function prepareEmitter(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		emitter.removeRendererSpecificInitializers();
		var compliantEmitter:IBaseEmitter = convertEmitterToCompliant(emitter);
		checkTypeCompliance(compliantEmitter, targetRenderCanvas);
		doPrepareEmitterTemplate(compliantEmitter, targetRenderCanvas);
	}

	private function convertEmitterToCompliant(emitter : IBaseEmitter) : IBaseEmitter
	{
		if(emitter is emitterType)
			return emitter;
		var obj:BaseEmitterValueObject = emitter as BaseEmitterValueObject;
		var newEmitter:IBaseEmitter = construct(emitterType,[obj.id,obj.emitter]);
		return newEmitter;
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
