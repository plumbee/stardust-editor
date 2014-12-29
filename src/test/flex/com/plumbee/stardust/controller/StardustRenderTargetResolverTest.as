package com.plumbee.stardust.controller
{
import com.plumbee.stardust.helpers.Globals;

import idv.cjcat.stardustextended.twoD.handlers.DisplayObjectHandler;
import idv.cjcat.stardustextended.twoD.starling.StarlingHandler;

import org.flexunit.asserts.assertEquals;

public class StardustRenderTargetResolverTest
{

	[Test]
	public function resolveReturnsGlobalCanvasIfParticleHandlerIsDisplayList() : void
	{
		assertEquals(Globals.canvas, new StardustRenderTargetResolver().resolve(new DisplayObjectHandler()));
	}

	[Test]
	public function resolveReturnsGlobalStarlingCanvasIfParticleHandlerIsStarling() : void
	{
		assertEquals(Globals.starlingCanvas, new StardustRenderTargetResolver().resolve(new StarlingHandler()));
	}

	[Test]
	public function resolveReturnsGlobalBitmapDataAsDefault() : void
	{
		assertEquals(Globals.bitmapData, new StardustRenderTargetResolver().resolve(null));
	}
}
}
