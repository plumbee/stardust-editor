package helpers
{
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.FileFilter;
import flash.net.FileReference;

import idv.cjcat.stardust.common.CommonClassPackage;
import idv.cjcat.stardust.common.StardustElement;
import idv.cjcat.stardust.common.xml.XMLBuilder;
import idv.cjcat.stardust.twoD.TwoDClassPackage;
import idv.cjcat.stardust.twoD.emitters.Emitter2D;

public class IOHelper
{

    private static var _loadFile : FileReference;
    private static var _onSimLoaded : Function;

    /** the onSimLoaded function should accept an Emitter2D as parameter */
    public static function loadSim( onSimLoaded : Function ) : void
    {
        _onSimLoaded = onSimLoaded;
        _loadFile = new FileReference();
        _loadFile.addEventListener(Event.SELECT, selectHandler);
        var fileFilter:FileFilter = new FileFilter("Stardust xml: (*.xml)", "*.xml");
        _loadFile.browse([fileFilter]);
    }

    private static function selectHandler( event : Event ) : void
    {
        _loadFile.removeEventListener(Event.SELECT, selectHandler);
        _loadFile.addEventListener(Event.COMPLETE, loadCompleteHandler);
        _loadFile.load();
    }

    private static function loadCompleteHandler( event : Event ) : void
    {
        _loadFile.removeEventListener(Event.COMPLETE, loadCompleteHandler);
        var xml:XML = new XML( _loadFile.data.readUTFBytes(_loadFile.data.length) );

        var builder : XMLBuilder = new XMLBuilder();
        builder.registerClassesFromClassPackage (CommonClassPackage.getInstance());
        builder.registerClassesFromClassPackage (TwoDClassPackage.getInstance());
        builder.buildFromXML( xml );

        // TODO: handle if it has multiple emitters
        var emitters: Vector.<StardustElement> = builder.getElementsByClass( Emitter2D );
        _onSimLoaded( emitters[0] );
    }

    public static function saveSim( emitter : Emitter2D ):void
    {
        var builder : XMLBuilder = new XMLBuilder();
        builder.registerClassesFromClassPackage (CommonClassPackage.getInstance());
        builder.registerClassesFromClassPackage (TwoDClassPackage.getInstance());
        var xml:XML = XMLBuilder.buildXML( emitter );

        var saveFile:FileReference = new FileReference();
        saveFile.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
        saveFile.save(xml, "stardustSim.xml");
    }

    private static function IOErrorHandler( e : IOErrorEvent ):void
    {
        trace("Error saving the file, details:\n"+ e.toString(),"ERROR");
    }

     /*
     function testA()
     {
         var builder : XMLBuilder = new XMLBuilder();
         builder.registerClassesFromClassPackage (CommonClassPackage.getInstance());
         builder.registerClassesFromClassPackage (TwoDClassPackage.getInstance());
         var xml:XML = XMLBuilder.buildXML( emitter );

         var reader : XMLBuilder = new XMLBuilder();
         reader.registerClassesFromClassPackage (CommonClassPackage.getInstance());
         reader.registerClassesFromClassPackage (TwoDClassPackage.getInstance());
         reader.buildFromXML( xml );

         var e2d : Emitter2D = reader.getElementByName("Emitter2D_0") as Emitter2D;
         parseStardustSim( e2d );
     }
     */
}
}
