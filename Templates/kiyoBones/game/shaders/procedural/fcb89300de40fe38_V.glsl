//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// Diffuse Color
// Diffuse Vertex Color
// Visibility
// Fog
// HDR Output
// Translucent
// Forward Shaded Material

struct VertexData
{
   vec3 position;
   vec4 diffuse;
} IN;

in vec3 vPosition;
#define IN_position IN.position
in vec4 vColor;
#define IN_diffuse IN.diffuse

out vec4 _COLOR_;
out vec3 _TEXCOORD0_;

// Struct defines
#define OUT_vertColor _COLOR_
#define OUT_outWsPosition _TEXCOORD0_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float4x4 modelview      ;
uniform float4x4 objTrans       ;


void main()
{

   //-------------------------
   IN.position = vPosition;
   IN.diffuse = vColor;
   //-------------------------

   // Vert Position
   gl_Position = tMul(modelview, vec4(IN_position.xyz,1));
   
   // Diffuse Color
   
   // Diffuse Vertex Color
   OUT_vertColor = IN_diffuse;
   
   // Visibility
   
   // Fog
   OUT_outWsPosition = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   
   // HDR Output
   
   // Translucent
   
   // Forward Shaded Material
   
   gl_Position.y *= -1;
}
