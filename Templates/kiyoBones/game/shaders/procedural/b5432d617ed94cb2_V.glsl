//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// Texture Animation
// Base Texture
// Diffuse Color
// Visibility
// Fog
// HDR Output
// Translucent
// Forward Shaded Material

struct VertexData
{
   vec3 position;
   float tangentW;
   vec3 normal;
   vec3 T;
   vec4 texCoord;
} IN;

in vec3 vPosition;
#define IN_position IN.position
in float vTangentW;
#define IN_tangentW IN.tangentW
in vec3 vNormal;
#define IN_normal IN.normal
in vec3 vTangent;
#define IN_T IN.T
in vec4 vTexCoord0;
#define IN_texCoord IN.texCoord

out vec2 _TEXCOORD0_;
out vec3 _TEXCOORD1_;

// Struct defines
#define OUT_out_texCoord _TEXCOORD0_
#define OUT_outWsPosition _TEXCOORD1_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float4x4 modelview      ;
uniform float4x4 texMat         ;
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
   
   // Texture Animation
   
   // Base Texture
   OUT_out_texCoord = vec2(tMul(texMat, IN_texCoord).xy);
   
   // Diffuse Color
   
   // Visibility
   
   // Fog
   OUT_outWsPosition = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   
   // HDR Output
   
   // Translucent
   
   // Forward Shaded Material
   
   gl_Position.y *= -1;
}