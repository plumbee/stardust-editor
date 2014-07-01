package com.plumbee.stardust.helpers
{
public class DropdownListVO
{
    public var name : String;
    public var stardustClass : Class;
    public var viewClass : Class;

    public function DropdownListVO( name : String, stardustClass : Class, viewClass : Class )
    {
        this.name = name;
        this.viewClass = viewClass;
        this.stardustClass = stardustClass;
    }
}
}
