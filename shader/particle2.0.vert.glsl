#define M_2_PI 6.28318530

VARYING vec2 vTexCoord;

mat4 rotate2d(float _angle)
{
   float angle = radians(_angle);//角度转为弧度
   return mat4(cos(angle),0.0,sin(angle),0.0,
               0.0,1.0,0.0,0.0,
               -sin(angle),0,cos(angle),0.0,
               0.0,0.0,0.0,1.0
               );
 }

void MAIN()
{    
    vec4 pos = vec4(VERTEX.xyz, 1.0);

    vTexCoord = UV0;
    POSITION = MODELVIEWPROJECTION_MATRIX * vec4( pos.xyz, 1.0);
}