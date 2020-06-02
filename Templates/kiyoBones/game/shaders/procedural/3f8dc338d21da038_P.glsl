//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// Visibility
// Eye Space Depth (Out)
// Hardware Instancing

in float _TEXCOORD0_;
in vec4 _TEXCOORD1_;
in float4 _TEXCOORD2_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float3   vEye           ;
uniform float4   oneOverFarplane;

void main()
{
   float3 vEye = vEye;
   float4 oneOverFarplane = oneOverFarplane;

   //-------------------------
   float IN_visibility = _TEXCOORD0_;
   vec4 IN_inVpos = _TEXCOORD1_;
   float4 IN_wsEyeVec = _TEXCOORD2_;
   //-------------------------

   // Vert Position
   
   // Visibility
   vec2 vpos = IN_inVpos.xy / IN_inVpos.w;
   fizzle( vpos, IN_visibility );
   
   // Eye Space Depth (Out)
#ifndef CUBE_SHADOW_MAP
   float eyeSpaceDepth = dot(vEye, (IN_wsEyeVec.xyz / IN_wsEyeVec.w));
#else
   float eyeSpaceDepth = length( IN_wsEyeVec.xyz / IN_wsEyeVec.w ) * oneOverFarplane.x;
#endif
   OUT_col = float4(float3(eyeSpaceDepth),1);
   
   // Hardware Instancing
   
   
}
