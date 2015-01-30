package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.DisplayListEmitterValueObject;
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.emitter.IDisplayListEmitter;

import flash.display.DisplayObjectContainer;

public class EmitterRenderingSetupDisplayList extends EmitterRenderingSetupBase
{
	public function EmitterRenderingSetupDisplayList()
	{
		emitterType = DisplayListEmitterValueObject;
		canvasType = DisplayObjectContainer;
	}


	override protected function doPrepareEmitterTemplate(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		var e : IDisplayListEmitter = emitter as IDisplayListEmitter;
		e.addDisplayListInitializers();
		e.updateHandlerCanvas(targetRenderCanvas);
	}
}
}
