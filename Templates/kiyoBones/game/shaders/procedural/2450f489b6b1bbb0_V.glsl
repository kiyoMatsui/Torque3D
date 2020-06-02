//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/lighting.glsl"
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// Diffuse Color
// RT Lighting
// Visibility
// Fog
// HDR Output
// Forward Shaded Material

struct VertexData
{
   vec3 position;
   float tangentW;
   vec3 normal;
   vec3 T;
   vec2 texCoord;
} IN;

in vec3 vPosition;
#define IN_position IN.position
in float vTangentW;
#define IN_tangentW IN.tangentW
in vec3 vNormal;
#define IN_normal IN.normal
in vec3 vTangent;
#define IN_T IN.T
in vec2 vTexCoord0;
#define IN_texCoord IN.texCoord

out vec3 _TEXCOORD0_;
out vec3 _TEXCOORD1_;
out vec4 _TEXCOORD2_;

// Struct defines
#define OUT_wsNormal _TEXCOORD0_
#define OUT_outWsPosition _TEXCOORD1_
#define OUT_outVpos _TEXCOORD2_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float4x4 modelview      ;
uniform float4x4 objTrans       ;


void main()
{

   //-------------------------
   IN.position = vPosition;
   IN.tangentW = vTangentW;
   IN.normal = vNormal;
   IN.T = vTangent;
   IN.texCoord = vTexCoord0;
   //-------------------------

   // Vert Position
   gl_Position = tMul(modelview, vec4(IN_position.xyz,1));
   
   // Diffuse Color
   
   // RT Lighting
   OUT_wsNormal = tMul( objTrans, vec4( normalize( IN_normal ), 0.0 ) ).xyz;
   OUT_outWsPosition = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   
   // Visibility
   OUT_outVpos = gl_Position;
   
   // Fog
   
   // HDR Output
   
   // Forward Shaded Material
   
   gl_Position.y *= -1;
}
