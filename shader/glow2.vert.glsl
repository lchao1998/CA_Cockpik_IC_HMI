VARYING vec2 vTexCoord;

void MAIN()
{
    vTexCoord = UV0+  vec2(textureOffsetU, textureOffsetV);
    POSITION = MODELVIEWPROJECTION_MATRIX * vec4(VERTEX.xyz, 1.0);
}
