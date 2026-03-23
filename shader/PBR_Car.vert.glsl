//#version 300 es

//uniform  float vColorAmount;
//uniform  mat4 environmentTransform;
//uniform  vec4 textureTransform;
//uniform  vec2 pBR_TextureOffset;
//uniform  vec2 pBR_TextureTiling;

VARYING  vec3 vNormalRotated;
VARYING  vec3 vNormal;
VARYING  vec3 vViewDirection;
VARYING  vec3 vViewDirectionRotated;
VARYING  vec4 vColor;
VARYING  vec2 vTexCoord;
VARYING  vec2 vTilableCoord;
VARYING  vec3 vTangent;
VARYING  vec3 vBinormal;

void MAIN()
{
    vec4 positionWorld = MODEL_MATRIX * vec4(VERTEX.xyz, 1.0);
    vViewDirection = positionWorld.xyz - CAMERA_POSITION;
    vViewDirectionRotated =  (environmentTransform * vec4(vViewDirection.xyz, 0.0)).xyz;
    
    vNormal = NORMAL_MATRIX * NORMAL;
    vNormalRotated =  (environmentTransform * vec4(vNormal,0.0)).xyz;
    
    float vcolorR = max(COLOR.r, 0.0);
    vColor = pow(mix(vec4(1.0), vec4(vec3(vcolorR), 1.0), vColorAmount), vec4(2.2));
    int i;

    vTangent = NORMAL_MATRIX * TANGENT;
    vBinormal = cross(vNormal, vTangent);
    vTexCoord = UV0 * textureTransform.xy + textureTransform.zw;
    vTilableCoord = UV0 * pBR_TextureTiling + pBR_TextureOffset;

    POSITION = MODELVIEWPROJECTION_MATRIX * vec4(VERTEX.xyz, 1.0);
}