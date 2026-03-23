VARYING vec2 vTexCoord;

//attribute vec3 VERTEX;
//attribute vec3 NORMAL;
//attribute vec2 UV0;
//uniform vec4 EMISSIVE;
//uniform vec4 Ambient;
//uniform vec4 DIFFUSE;
//uniform vec4 SPECULAR;

//uniform mat4 MODELVIEWPROJECTION_MATRIX;
//uniform mat4 MODEL_MATRIX;
//uniform mat4 NORMAL_MATRIX;
//uniform vec4 VIEW_POSITION;

//uniform float curvature;
//uniform vec2 textureOffset;
//uniform vec2 textureTiling;
//uniform lowp float blendIntensity;


//uniform float SpecularExponent


mat4 rotate2d(float _angle){
   float angle = radians(_angle);
   return mat4(cos(angle),0.0,sin(angle),0.0,
               0.0,1.0,0.0,0.0,
               -sin(angle),0,cos(angle),0.0,
               0.0,0.0,0.0,1.0
               );
 }

void MAIN()
{
    vec3 viewDirection;
    vec3 normal;
    
    vec4 pos = vec4(VERTEX.xyz, 1.0);
    pos *= rotate2d(90.0);
    
    vTexCoord = UV0 * textureTiling + vec2(textureOffsetU,textureOffsetV);
    float x = pos.x;
    float y = pos.y;
    float a = curvature*0.000001;
    float z ;

    if(x<-120.0){
    z =  pos.z+a*(x+10.0*12.5)*(x+10.0*12.5)*(x+10.0*12.5);}
    else{
    z = pos.z+a*(-120.0+10.0*12.5)*(-120.0+10.0*12.5)*(-120.0+10.0*12.5);} 
    pos=vec4(x,y,z,1.0);

    POSITION = MODELVIEWPROJECTION_MATRIX * vec4(pos.xyz, 1.0);  
    //vec4 positionWorld = MODEL_MATRIX * vec4(pos.xyz, 1.0);
    //viewDirection = positionWorld.xyz * VIEW_POSITION.w - VIEW_POSITION.xyz;
    //vec3 V = normalize(viewDirection);
    //vec4 Norm = NORMAL_MATRIX * vec4(NORMAL, 0.0);
    //normal = normalize(Norm.xyz);

}