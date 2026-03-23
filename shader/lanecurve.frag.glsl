//uniform float blendIntensity;
//uniform vec4 Ambient;

VARYING vec2 vTexCoord;

//uniform sampler2D texture1;
//uniform sampler2D textureMask;
//uniform vec2 textureOffset;


void MAIN()
{
    vec3 color = vec3(0.0); 
    vec4 baseColor = texture(texture1, vTexCoord + vec2(textureOffsetU, textureOffsetV)).rgba * texture(textureMask, vTexCoord+vec2(textureOffsetU, textureOffsetV)).a;
    color += baseColor.rgb;

    FRAGCOLOR = vec4(color,baseColor.a) * blendIntensity;
}