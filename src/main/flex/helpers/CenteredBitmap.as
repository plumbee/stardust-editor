package helpers
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

public class CenteredBitmap extends Sprite
{

    public function CenteredBitmap( bd : BitmapData )
    {
        var bmp:Bitmap = new Bitmap(bd);
        bmp.x = -bmp.width*0.5;
        bmp.y = -bmp.height*0.5;
        addChild( bmp );
    }
}
}
