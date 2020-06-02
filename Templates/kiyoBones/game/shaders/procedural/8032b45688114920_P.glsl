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
// Hardware Instancing

in float2 _TEXCOORD0_;
in float _TEXCOORD1_;
in vec4 _TEXCOORD2_;
in float _TEXCOORD3_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------

void main()
{

   //-------------------------
   float2 IN_posXY = _TEXCOORD0_;
   float IN_visibility = _TEXCOORD1_;
   vec4 IN_inVpos = _TEXCOORD2_;
   float IN_depth = _TEXCOORD3_;
   //-------------------------

   // Paraboloid Vert Transform
   clip( 1.0 - abs(IN_posXY.x) );
   
   // Visibility
   vec2 vpos = IN_inVpos.xy / IN_inVpos.w;
   fizzle( vpos, IN_visibility );
   
   // Depth (Out)
   OUT_col = float4( IN_depth, 0, 0, 1 );
   
   // Hardware Instancing
   
   
}
