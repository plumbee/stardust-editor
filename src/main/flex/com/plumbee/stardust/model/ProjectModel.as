package com.plumbee.stardust.model
{

import com.plumbee.stardustplayer.emitter.BaseEmitterValueObject;
import com.plumbee.stardustplayer.project.ProjectValueObject;

public class ProjectModel
{

	public var emitterInFocus : BaseEmitterValueObject;
	public var stadustSim : ProjectValueObject;

	public function getDisplayMode() : String
	{
		return stadustSim.displayMode;
	}

	public function setDisplayMode(displayMode : String) : void
	{
		stadustSim.displayMode = displayMode;
	}

}
}