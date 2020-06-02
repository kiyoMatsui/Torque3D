//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Hardware Skinning
// Paraboloid Vert Transform
// Visibility
// Depth (Out)
// Single Pass Paraboloid

in float _TEXCOORD0_;
in float2 _TEXCOORD1_;
in vec4 _TEXCOORD2_;
in float _TEXCOORD3_;

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
   float IN_isBack = _TEXCOORD0_;
   float2 IN_posXY = _TEXCOORD1_;
   vec4 IN_inVpos = _TEXCOORD2_;
   float IN_depth = _TEXCOORD3_;
   //-------------------------

   // Hardware Skinning
   
   // Paraboloid Vert Transform
   if ( ( abs( IN_isBack ) - 0.999 ) < 0 ) discard;
   clip( 1.0 - abs(IN_posXY.x) );
   
   // Visibility
   vec2 vpos = IN_inVpos.xy / IN_inVpos.w;
   fizzle( vpos, visibility );
   
   // Depth (Out)
   OUT_col = float4( IN_depth, 0, 0, 1 );
   
   // Single Pass Paraboloid
   
   
}
