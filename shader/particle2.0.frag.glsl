VARYING vec2 vTexCoord;

void MAIN()
{
 
   vec3 col2=vec3(0.0);
    for(float j = 0.0; j < 5.0; j++){
   vec2 uv2 =vTexCoord;
    uv2.y-=j/5.;
    uv2.x-=1.;
    uv2.x+=fract((speed+0.7)*uTime+j*0.3);
    
    uv2.x=uv2.x/0.2;
    uv2.y=uv2.y/0.01;
    
    float d=1.-smoothstep(0.,1.,length(uv2));
 
    col2 +=vec3(1.0, 0.55, 0.25) * d;
    }
  col2=col2;
    

    vec3 col3=vec3(0.0);
    for(float j = 0.0; j < 8.0; j++){
   vec2 uv2 =vTexCoord;
    uv2.y-=j/8.;
    uv2.x-=1.;
    uv2.x+=fract(speed*uTime+j*0.3);
    
    uv2.x=uv2.x/0.15;
    uv2.y=uv2.y/0.01;
    
    float d=1.-smoothstep(0.,1.,length(uv2));
 
    col2 +=vec3(0.25, 0.55, 1.00)* d;
    }
  col3=col3;
   
     
    FRAGCOLOR= vec4(vec3(col2+col3),0.0) * blendIntensity;
}
