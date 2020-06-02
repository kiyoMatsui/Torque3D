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
// Single Pass Paraboloid
// Hardware Instancing

in float _TEXCOORD0_;
in float2 _TEXCOORD1_;
in float _TEXCOORD2_;
in vec4 _TEXCOORD3_;
in float _TEXCOORD4_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------

void main()
{

   //-------------------------
   float IN_isBack = _TEXCOORD0_;
   float2 IN_posXY = _TEXCOORD1_;
   float IN_visibility = _TEXCOORD2_;
   vec4 IN_inVpos = _TEXCOORD3_;
   float IN_depth = _TEXCOORD4_;
   //-------------------------

   // Paraboloid Vert Transform
   if ( ( abs( IN_isBack ) - 0.999 ) < 0 ) discard;
   clip( 1.0 - abs(IN_posXY.x) );
   
   // Visibility
   vec2 vpos = IN_inVpos.xy / IN_inVpos.w;
   fizzle( vpos, IN_visibility );
   
   // Depth (Out)
   OUT_col = float4( IN_depth, 0, 0, 1 );
   
   // Single Pass Paraboloid
   
   // Hardware Instancing
   
   
}
