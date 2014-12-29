package com.plumbee.stardust.controller
{
import com.plumbee.stardust.helpers.Globals;

import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

public class StardustRenderTargetResolver
{
	public function resolve(particleHandler : ParticleHandler) : *
	{
		if(particleHandler is DisplayObjectHandler)
			return Globals.canvas;
		if(particleHandler is StarlingHandler)
			return Globals.starlingCanvas;
		return Globals.bitmapData;
	}
}
}
