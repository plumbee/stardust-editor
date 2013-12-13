package helpers
{
import flash.net.SharedObject;

public class LocalConfig
{
    private static const so : SharedObject = SharedObject.getLocal("stardustGUI");

    public static function saveProperty( prop : LocalConfigEnum, value : Object) : void
    {
        so.data[prop.name] = value;
        so.flush();
    }

    public static function getProperty( prop : LocalConfigEnum ) : Object
    {
        return so.data[prop.name];
    }

    public static function deleteProperty( prop : LocalConfigEnum ) : void
    {
        so.data[prop.name] = undefined;
    }

}
}
