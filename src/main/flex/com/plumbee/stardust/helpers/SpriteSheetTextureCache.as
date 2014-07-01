package com.plumbee.stardust.helpers
{
import flash.geom.Rectangle;

import starling.textures.SubTexture;
import starling.textures.Texture;

public class SpriteSheetTextureCache
{
    public var textures : Vector.<SubTexture> = new Vector.<SubTexture>();
    private var imgWidth : int = 10;
    private var imgHeight : int = 10;
    public var name : String;

    public function SpriteSheetTextureCache( emitterIndex : int )
    {
        name = "emitter_" + emitterIndex;
    }

    public function init( texture : Texture, imgWidth : int, imgHeight : int ) : void
    {
        if ( textures && textures.length > 0 )
        {
            return;
        }

        setInfo( name, imgWidth, imgHeight );
        refresh( texture );
    }

    public function refresh( texture : Texture ) : void
    {
        textures = new Vector.<SubTexture>();
        const xIter : int = Math.floor( texture.width / imgWidth );
        const yIter : int = Math.floor( texture.height / imgHeight );

        for ( var j : int = 0; j < yIter; j ++ )
        {
            for ( var i : int = 0; i < xIter; i ++ )
            {
                textures.push( new SubTexture( texture, new Rectangle( i * imgWidth, j * imgHeight, imgWidth, imgHeight ) ) );
            }
        }
    }

    public function clear() : void
    {
        if ( textures )
        {
            var numTextures : int = textures.length;
            for ( var i : int = 0; i < numTextures; i ++ )
            {
                textures[i].dispose();
            }

            textures = null;
            name = "";
        }
    }

    public function isEmpty() : Boolean
    {
        return (! textures || textures.length == 0);
    }

    public function setInfo( name : String, imgWidth : int, imgHeight : int ) : void
    {
        this.name = name;
        this.imgWidth = imgWidth;
        this.imgHeight = imgHeight;
    }
}
}
