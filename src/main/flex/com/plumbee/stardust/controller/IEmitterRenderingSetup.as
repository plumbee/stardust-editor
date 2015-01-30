package com.plumbee.stardust.controller
{
import com.plumbee.stardustplayer.emitter.IBaseEmitter;

public interface IEmitterRenderingSetup
{
	function prepareEmitter(emitter : IBaseEmitter, targetRenderCanvas:*) : void;
}
}
