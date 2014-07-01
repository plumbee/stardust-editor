/**
 * Created with IntelliJ IDEA.
 * User: BenP
 * Date: 27/11/13
 * Time: 11:36
 * To change this template use File | Settings | File Templates.
 */
package com.plumbee.stardust.helpers.starling
{
import com.plumbee.stardust.helpers.SpriteSheetTextureCache;

import flash.display.Bitmap;
import flash.display.BitmapData;

import starling.textures.Texture;
import starling.textures.TextureAtlas;

import treefortress.textureutils.AtlasBuilder;

public class TextureManager
{
    private static var TEXTURE_PREFIX : String = "emitter_";

    private var spriteSheetCaches : Array = [];
    private var sourceBitmaps : Vector.<Bitmap>;

    private var atlas : TextureAtlas;

    public function TextureManager()
    {
        sourceBitmaps = new Vector.<Bitmap>();
    }

    public function clear() : void
    {
        var numCaches : int = spriteSheetCaches.length - 1;
        for ( var i : int = numCaches; i > - 1; i -- )
        {
            if ( spriteSheetCaches[i] )
            {
                (spriteSheetCaches[i] as SpriteSheetTextureCache).clear();
                delete spriteSheetCaches[i];
            }
        }
        spriteSheetCaches.length = 0;
    }

    public function addSingleTexture( sourceBD : BitmapData, emitterIndex : int ) : Texture
    {
        var sourceChanged : Boolean = addSourceBitmap( sourceBD, TEXTURE_PREFIX + emitterIndex );

        if ( sourceChanged )
        {
            atlas = AtlasBuilder.build( sourceBitmaps );
        }

        var texture : Texture = atlas.getTexture( TEXTURE_PREFIX + emitterIndex );

        return texture;
    }

    public function addSpriteSheet( sourceBD : BitmapData, imgWidth : int, imgHeight : int, emitterIndex : int ) : SpriteSheetTextureCache
    {
        var spriteSheetCache : SpriteSheetTextureCache = getSpriteSheetCache( emitterIndex );
        var sourceChanged : Boolean = addSourceBitmap( sourceBD, spriteSheetCache.name );

        if ( sourceChanged )
        {
            atlas = AtlasBuilder.build( sourceBitmaps );
        }

        if ( sourceChanged || spriteSheetCache.isEmpty() )
        {
            spriteSheetCache.setInfo( TEXTURE_PREFIX + emitterIndex, imgWidth, imgHeight );
            refreshSpriteSheetCaches();
        }

        return spriteSheetCache;
    }

    //need to recreate the sprite sheets together to make sure they're using the same atlas and concrete texture.
    private function refreshSpriteSheetCaches() : void
    {
        for each( var cache : Object in spriteSheetCaches )
        {
            var spriteCache : SpriteSheetTextureCache = cache as SpriteSheetTextureCache;
            var texture : Texture = atlas.getTexture( spriteCache.name );
            spriteCache.refresh( texture );
        }
    }

    private function addSourceBitmap( sourceBD : BitmapData, name : String ) : Boolean
    {
        var numBitmaps : int = sourceBitmaps.length;
        for ( var i : int = 0; i < numBitmaps; i ++ )
        {
            if ( sourceBitmaps[i].name == name )
            {

                if ( sourceBD == sourceBitmaps[i].bitmapData )
                {
                    return false;
                }

                var newBitmap : Bitmap = new Bitmap( sourceBD );
                newBitmap.name = name;
                sourceBitmaps[i] = newBitmap;
                return true;
            }
        }

        newBitmap = new Bitmap( sourceBD );
        newBitmap.name = name;
        sourceBitmaps.push( newBitmap );
        return true;
    }

    public function getSpriteSheetCache( emitterIndex : int ) : SpriteSheetTextureCache
    {
        if ( ! spriteSheetCaches[ emitterIndex ] )
        {
            spriteSheetCaches[ emitterIndex ] = new SpriteSheetTextureCache( emitterIndex );
        }

        return spriteSheetCaches[ emitterIndex ];
    }
}
}
