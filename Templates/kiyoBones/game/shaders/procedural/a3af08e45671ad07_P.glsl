//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Hardware Skinning
// Vert Position
// Visibility
// Eye Space Depth (Out)

in vec4 _TEXCOORD0_;
in float4 _TEXCOORD1_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float    visibility     ;
uniform float3   vEye           ;
uniform float4   oneOverFarplane;

void main()
{
   float visibility = visibility;
   float3 vEye = vEye;
   float4 oneOverFarplane = oneOverFarplane;

   //-------------------------
   vec4 IN_inVpos = _TEXCOORD0_;
   float4 IN_wsEyeVec = _TEXCOORD1_;
   //-------------------------

   // Hardware Skinning
   
   // Vert Position
   
   // Visibility
   vec2 vpos = IN_inVpos.xy / IN_inVpos.w;
   fizzle( vpos, visibility );
   
   // Eye Space Depth (Out)
#ifndef CUBE_SHADOW_MAP
   float eyeSpaceDepth = dot(vEye, (IN_wsEyeVec.xyz / IN_wsEyeVec.w));
#else
   float eyeSpaceDepth = length( IN_wsEyeVec.xyz / IN_wsEyeVec.w ) * oneOverFarplane.x;
#endif
   OUT_col = float4(float3(eyeSpaceDepth),1);
   
   
}
