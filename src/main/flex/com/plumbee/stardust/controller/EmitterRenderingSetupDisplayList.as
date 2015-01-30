package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.emitter.IDisplayListEmitter;

import flash.display.DisplayObjectContainer;

public class EmitterRenderingSetupDisplayList implements IEmitterRenderingSetup
{
	public function prepareEmitter(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		if (!(emitter is IDisplayListEmitter) ||
			!(targetRenderCanvas is DisplayObjectContainer))
		{
			throw(new TypeError("type not handled"));
		}
		doPrepareEmitter(emitter as IDisplayListEmitter, targetRenderCanvas);
	}

	private function doPrepareEmitter(emitter : IDisplayListEmitter, targetRenderCanvas : DisplayObjectContainer) : void
	{
		emitter.removeRendererSpecificInitializers();
		emitter.addDisplayListInitializers();
		emitter.updateHandlerCanvas(targetRenderCanvas);
	}
}
}
