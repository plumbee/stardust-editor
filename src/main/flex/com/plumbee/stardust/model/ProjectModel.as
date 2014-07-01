package com.plumbee.stardust.model
{

import com.plumbee.stardustplayer.emitter.EmitterValueObject;
import com.plumbee.stardustplayer.project.DisplayModes;
import com.plumbee.stardustplayer.project.ProjectValueObject;

import flash.display.DisplayObject;
import flash.utils.ByteArray;

public class ProjectModel
{

    public var emitterInFocus : EmitterValueObject;
    public var stadustSim : ProjectValueObject;

    public function getDisplayMode() : String
    {
        return stadustSim.displayMode;
    }

    public function setDisplayMode( displayMode : String ) : void
    {
        stadustSim.displayMode = displayMode;
    }

}
}