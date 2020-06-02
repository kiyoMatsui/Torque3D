//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Paraboloid Vert Transform
// Visibility
// Depth (Out)

in float2 _TEXCOORD0_;
in vec4 _TEXCOORD1_;
in float _TEXCOORD2_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float    visibility     ;

void main()
{
   float visibility = visibility;

   //-------------------------
   float2 IN_posXY = _TEXCOORD0_;
   vec4 IN_inVpos = _TEXCOORD1_;
   float IN_depth = _TEXCOORD2_;
   //-------------------------

   // Paraboloid Vert Transform
   clip( 1.0 - abs(IN_posXY.x) );
   
   // Visibility
   vec2 vpos = IN_inVpos.xy / IN_inVpos.w;
   fizzle( vpos, visibility );
   
   // Depth (Out)
   OUT_col = float4( IN_depth, 0, 0, 1 );
   
   
}
