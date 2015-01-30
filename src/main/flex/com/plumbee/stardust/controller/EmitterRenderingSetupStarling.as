package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;
import com.plumbee.stardustplayer.emitter.IStarlingEmitter;
import com.plumbee.stardustplayer.emitter.StarlingEmitterValueObject;

import starling.display.DisplayObjectContainer;

public class EmitterRenderingSetupStarling extends EmitterRenderingSetupBase
{
	public function EmitterRenderingSetupStarling()
	{
		emitterType = StarlingEmitterValueObject;
		canvasType = DisplayObjectContainer;
	}

	override protected function doPrepareEmitterTemplate(emitter : IBaseEmitter, targetRenderCanvas : *) : void
	{
		var e : IStarlingEmitter = emitter as IStarlingEmitter;
		e.addStarlingInitializers();
		e.updateHandlerCanvas(targetRenderCanvas);
	}
}
}
