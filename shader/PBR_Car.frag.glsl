//#version 300 es
#define PI 3.1415926535

//uniform vec4 pBR_ambient;
//uniform vec4 pBR_Lightcolor;
//uniform float pBR_Roughness;
//uniform float pBR_Metalness;
//uniform vec4 pBR_emissive;
//uniform float pBR_emissiveIntensity;
//uniform float blendIntensity;
//uniform float pBR_HardShading;

//uniform  float exposure;
//uniform  float a;
//uniform  float b;
//uniform  float c;
//uniform  float d;
//uniform  float e;
//uniform  float f;
//uniform  float w;
//uniform  float reflectionStrength;
//uniform  float reflectionStrengthLocal;
//uniform  float ambientStrength;
//uniform  float fresnelStrength;
//uniform  float fresnelStrengthLocal;

//uniform sampler2d pBR_Tex_Noise_NormalMap;
//uniform float pBR_Noise_NormalMapStrength;
//uniform vec4 pBR_albedo;
//uniform float pBR_Noise_Roughness;
//uniform sampler2d pBR_Tex_Noise_Roughness;
//uniform float pBR_Noise_RoughnessOffset;
//uniform sampler2d pBR_Tex_Noise_ambientOcclusion;
//uniform float pBR_ambientOcclusionStrength;
//uniform float pBR_clearcoat_Strength;
//uniform float pBR_clearcoat_Roughness;
//uniform float pBR_clearcoat_SpecularRoughness;
//uniform float pBR_clearcoat_Metalness;


VARYING vec3 vNormalRotated;
VARYING vec3 vNormal;
VARYING vec3 vViewDirectionRotated;
VARYING vec3 vViewDirection;
VARYING vec4 vColor;

VARYING vec2 vTexCoord;
VARYING vec2 vTilableCoord;
VARYING vec3 vTangent;
VARYING vec3 vBinormal;

//VARYING vec3 vTO_LIGHT_DIR;
//uniform vec4 LIGHT_COLOR;
//uniform int lights_directional;

//out  vec4  outcolor;

vec4 screenSpacedither()
{
    vec3 dither = vec3(dot( vec2( 171.0, 231.0 ), FRAGCOORD.xy));
    dither.rgb = fract( dither.rgb / vec3( 103.0, 71.0, 97.0 ) ) - vec3( 0.5, 0.5, 0.5 );
    return vec4(( dither.rgb / 255.0 ) * 0.375, 0.0);
}

float curvature(vec3 N)
{
    vec3 fwidth = fwidth(N);
    float clampeddot = max( min( dot( fwidth, fwidth ), 1.0 ), 0.0 );
    return pow( clampeddot, 0.333 );
}

 float distribution( float NDotH, float roughness)
{
     float a = max(roughness * roughness, 0.001);
     float a2 = a * a;
     float NDotH2 = NDotH * NDotH;
     float f = (NDotH2 * (a2 - 1.0) + 1.0);
    return a2 / (PI * f * f);
}

 float Geometry( float NDotV,  float NDotL, float roughness)
{
    float a = roughness + 1.0;
    float k = (a * a) / 8.0;
     float GGXV = NDotV / (NDotV * (1.0 - k) + k);
     float GGXL = NDotL / (NDotL * (1.0 - k) + k);
    return GGXV * GGXL;
}

vec3 Uncharted2ToneMapping(vec3 color)
{
    color *= exposure;
    color = ((color * (a * color + c * b) + d * e) / (color * (a * color + b) + d * f)) - e / f;
    float white = ((w * (a * w + c * b) + d * e) / (w * (a * w + b) + d * f)) - e / f;
    color /= white;
    return color;
}

 float clearcoatGeometry( float LdotH, float roughness)
{
    float a = roughness / 2.0;
    float k = a * a;
    float invK = 1.0 - k;
    return 1.0 / (LdotH * LdotH * invK + k);
}

 vec3 fresnelfun( float cosT, vec3 FO)
{
  return FO + (1.0-FO) * pow( 1.0 - cosT, 5.0);
}

 vec3 Tonemap( vec3 color)
{
     vec3 uc2Tonemapper = Uncharted2ToneMapping(max(color, vec3(0.00001)));
     vec3 outcolor = pow(uc2Tonemapper, vec3(0.4545));
    return outcolor;
}

vec3 light_dir;
vec3 light_color;

void DIRECTIONAL_LIGHT()
{
    light_dir=TO_LIGHT_DIR;
    light_color=LIGHT_COLOR;

    DIFFUSE += BASE_COLOR.rgb*LIGHT_COLOR * SHADOW_CONTRIB * vec3(max(0.0, dot(normalize(VAR_WORLD_NORMAL), TO_LIGHT_DIR)));
}


void MAIN()
{
     vec3 color = vec3(0.0);
     vec3 V = normalize(vViewDirection);
     vec3 Vrot = normalize(vViewDirectionRotated);

     vec4 albedo = pBR_albedo;

     float metalness = clamp(pBR_Metalness, 0.0, 1.0);

     float roughness = clamp(texture(pBR_Tex_Noise_Roughness, vTilableCoord).r * pBR_Noise_Roughness + pBR_Noise_RoughnessOffset, 0.0, 1.0);  

     vec3 emissive = pBR_emissive.rgb;

     float AO = clamp(1.0 - (1.0 - texture(pBR_Tex_Noise_ambientOcclusion, vTexCoord).r) * pBR_ambientOcclusionStrength, 0.0, 1.0);

     float cavity = smoothstep(0.0, 0.2, AO);

     vec3 textureNormal = texture(pBR_Tex_Noise_NormalMap, vTilableCoord).xyz;
     vec3 Normalfactor = mix(vec3(0.0, 0.0, 1.0), textureNormal * 2.0 - 1.0, pBR_Noise_NormalMapStrength);
     vec3 N = normalize(vec3(vTangent * Normalfactor.x + 
                  vBinormal * Normalfactor.y +
                  vNormal * Normalfactor.z));                  

     float curv = curvature(normalize(vNormal));
     roughness = max(curv, roughness);   
     vec3 NRot = normalize(vNormalRotated);
   
    color += pBR_ambient. rgb* albedo.rgb * AO * cavity;

    int i;
    float mainLight;

    for (i = 0; i < lights_directional; ++i)
    {
        vec3 L = -light_dir;
        vec3 H = normalize(-V + L);
        
        float NDotH = clamp(max(0.0, dot(N, H)), 0.0, 1.0);
        float NDotV = clamp(max(0.0, dot(N, -V)), 0.0, 1.0);
        float NDotL = clamp(max(0.0, dot(N, L)), 0.0, 1.0);
        float HDotV = clamp(max(0.0, dot(H, -V)), 0.0, 1.0);
        
        vec3 FO = mix(vec3(0.04), albedo.rgb, metalness);
        float dist = distribution(NDotH, roughness);
        float geo = Geometry(NDotV, NDotL, roughness);
        // vec3 fresnel = fresnelfun(HDotV, FO);
        vec3 fresnel = fresnelfun(NDotV, FO);
        vec3 specularNum = (dist * geo) * fresnel;
        float speculardenom = max(0.004, 4.0 * NDotV * NDotH);
        vec3 specular = specularNum / speculardenom;
        vec3 diffuse =  ((1.0 / PI) *  albedo.rgb) * (1.0 - metalness) * NDotL;
        
        vec3 ccFO = mix(vec3(0.04), albedo.rgb, pBR_clearcoat_Metalness);
        float ccRoughness = mix(0.03, 0.6, pBR_clearcoat_SpecularRoughness);
        vec3 rawNormal = normalize(vNormal);
        float ccNDotH = max(0.0, dot(rawNormal, H));
        float ccNDotV = max(0.0, dot(rawNormal, -V));
        
        float ccdist = distribution(ccNDotH, ccRoughness);
        vec3 ccfresnel = fresnelfun(ccNDotV, ccFO) * pBR_clearcoat_Strength;
        vec3 ccSpecular = ccdist * ccfresnel;
        if(i == 0){mainLight = clamp(dot(vNormal, L), 0.0, 1.0);}
        color += ((diffuse + specular * (1.0-ccfresnel)) * (1.0-ccfresnel) + ccSpecular) *pBR_Lightcolor.rgb * vColor.rgb * AO * cavity;
    }

    color *= mix(1.0, max(mainLight, 0.0), pBR_HardShading);
    color += emissive * vColor.r * pBR_emissiveIntensity;
    color *= blendIntensity;
    BASE_COLOR= vec4(Tonemap(color) + screenSpacedither().rgb*5.0, blendIntensity);
    //BASE_COLOR=vec4(0.3,0.5,0.9,1);
}