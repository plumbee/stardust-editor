package com.plumbee.stardust.controller
{

import com.plumbee.stardust.model.ProjectModel;
import com.plumbee.stardustplayer.SimLoader;
import com.plumbee.stardustplayer.emitter.EmitterValueObject;
import com.plumbee.stardustplayer.project.ProjectValueObject;

import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.FileReference;
import flash.utils.ByteArray;

import idv.cjcat.stardustextended.common.xml.XMLBuilder;

import mx.controls.Alert;
import mx.graphics.codec.PNGEncoder;

import org.as3commons.zip.Zip;

import robotlegs.bender.extensions.commandCenter.api.ICommand;

public class SaveSimCommand implements ICommand
{
    [Inject]
    public var dispatcher : IEventDispatcher;

    [Inject]
    public var projectSettings : ProjectModel;

    private function IOErrorHandler( e : IOErrorEvent ) : void
    {
        Alert.show( "Error saving the file, details:\n" + e.toString(), "ERROR" );
    }

    public function execute() : void
    {
        const saveFile : FileReference = new FileReference();
        saveFile.addEventListener( IOErrorEvent.IO_ERROR, IOErrorHandler );
        saveFile.save( constructProjectFileByteArray(), "stardustProject.sde" );
    }

    private function constructProjectFileByteArray() : ByteArray
    {
        const zip : Zip = new Zip();
        const descObj : Object = {};
        descObj.version = 1;

        addEmittersToProjectFile( zip, descObj );
        addBackgroundToProjectFile( zip, descObj );

        zip.addFileFromString( SimLoader.DESCRIPTOR_FILENAME, JSON.stringify( descObj ) );
        const zippedData : ByteArray = new ByteArray();
        zip.serialize( zippedData, false );
        return zippedData;
    }

    private function addEmittersToProjectFile( zip : Zip, descObj : Object ) : void
    {
        const emitterArr : Array = [];
        for each (var emitterVO : EmitterValueObject in projectSettings.stadustSim.emitters)
        {
            emitterArr.push( {id : emitterVO.id.toString() });

            var pngEncoder : PNGEncoder = new PNGEncoder();
            zip.addFile( emitterVO.imageName, pngEncoder.encode( emitterVO.image ), false );
            zip.addFileFromString( emitterVO.xmlName, XMLBuilder.buildXML( emitterVO.emitter ).toString() );
        }
        descObj.emitters = emitterArr;
    }

    private function addBackgroundToProjectFile( zip : Zip, descObj : Object ) : void
    {
        const sim : ProjectValueObject = projectSettings.stadustSim;
        if ( sim.backgroundImage != null )
        {
            zip.addFile( sim.backgroundFileName, sim.backgroundRawData );
            descObj.backgroundFileName = sim.backgroundFileName;
        }
        else
        {
            descObj.backgroundFileName = "";
        }
        if ( sim.hasBackground )
        {
            descObj.hasBackground = "true";
        }
        else
        {
            descObj.hasBackground = "false";
        }
        descObj.backgroundColor = sim.backgroundColor;
    }

}
}
