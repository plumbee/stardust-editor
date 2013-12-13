package helpers
{
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

public class SpriteSheetBitmap extends Sprite
{
    private static var prevBD : BitmapData;
    private static var bds : Vector.<BitmapData> = new Vector.<BitmapData>();
    private static var animSpeed : uint;
    private var currImage : uint = 0;
    private var currFrame : uint = 0;
    private const bmp : Bitmap = new Bitmap();

    private static function init( bd : BitmapData, imgWidth : Number, imgHeight : Number ) : void
    {
        if ( bd == prevBD && bds.length > 0 && bds[0].width == imgWidth && bds[0].height == imgHeight)
        {
            return;
        }
        prevBD = bd;
        bds = new Vector.<BitmapData>();
        const xIter : int = Math.floor( bd.width / imgWidth );
        const yIter : int = Math.floor( bd.height / imgHeight );
        for (var j : int = 0; j < yIter; j++)
        {
            for (var i : int = 0; i < xIter; i++)
            {
                var singleSprite:BitmapData = new BitmapData(imgWidth, imgHeight);
                singleSprite.copyPixels( bd, new Rectangle(i * imgWidth, j * imgHeight, imgWidth, imgHeight), new Point(0,0) );
                bds.push( singleSprite );
            }
        }
    }

    public function SpriteSheetBitmap( bd : BitmapData,
                                       imgWidth : Number,
                                       imgHeight : Number,
                                       _animSpeed : uint,
                                       startAtRandomFrame : Boolean )
    {
        if ( imgWidth > bd.width || imgHeight > bd.height )
        {
            return;
        }
        if ( _animSpeed == 0 )
        {
            _animSpeed = 1;
        }
        animSpeed = _animSpeed;
        currFrame = _animSpeed;
        init(bd, imgWidth, imgHeight);

        addChild( bmp );
        bmp.x = -imgWidth / 2;
        bmp.y = -imgHeight / 2;
        if ( startAtRandomFrame )
        {
            currImage = Math.random() * bds.length;
        }

        addEventListener( Event.ADDED_TO_STAGE, addEnterFrameListener);
    }

    private function addEnterFrameListener( e : Event ) : void
    {
        removeEventListener( Event.ADDED_TO_STAGE, addEnterFrameListener);
        addEventListener( Event.ENTER_FRAME, onEnterFrame );
        addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
    }

    private function onEnterFrame( e : Event ) : void
    {
        if ( currFrame == animSpeed )
        {
            bmp.bitmapData = bds[currImage];
            currImage++;
            if (currImage == bds.length)
            {
                currImage = 0;
            }
            currFrame = 0;
        }
        currFrame++;
    }

    private function onRemoved( e : Event ) : void
    {
        currImage = 0;
        currFrame = animSpeed;
        removeEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
        removeEventListener( Event.ENTER_FRAME, onEnterFrame );
        addEventListener( Event.ADDED_TO_STAGE, addEnterFrameListener);
    }

}
}
