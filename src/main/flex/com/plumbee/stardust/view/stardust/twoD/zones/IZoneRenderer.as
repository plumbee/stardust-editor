package com.plumbee.stardust.view.stardust.twoD.zones {
import idv.cjcat.stardustextended.twoD.zones.Zone;

import mx.core.IVisualElement;

public interface IZoneRenderer extends IVisualElement{

    function setData(d : Zone) : void;
}
}
