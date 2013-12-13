package helpers
{
public class LocalConfigEnum
{

    public static const BACKGROUND_COLOR : LocalConfigEnum = new LocalConfigEnum("background_color");
    public static const ZONES_VISIBLE : LocalConfigEnum = new LocalConfigEnum("zones_visible");

    private var _name : String;

    public function get name() : String
    {
        return _name;
    }

    public function LocalConfigEnum( __name : String)
    {
        _name = __name;
    }
}
}
