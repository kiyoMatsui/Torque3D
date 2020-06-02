//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/lighting.glsl"
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// Base Texture
// RT Lighting
// Visibility
// Fog
// HDR Output
// Forward Shaded Material

struct VertexData
{
   vec3 position;
   vec3 normal;
   vec3 T;
   vec3 B;
   vec2 texCoord;
   vec2 texCoord2;
} IN;

in vec3 vPosition;
#define IN_position IN.position
in vec3 vNormal;
#define IN_normal IN.normal
in vec3 vTangent;
#define IN_T IN.T
in vec3 vBinormal;
#define IN_B IN.B
in vec2 vTexCoord0;
#define IN_texCoord IN.texCoord
in vec2 vTexCoord1;
#define IN_texCoord2 IN.texCoord2

out vec2 _TEXCOORD0_;
out vec3 _TEXCOORD1_;
out vec3 _TEXCOORD2_;
out vec4 _TEXCOORD3_;

// Struct defines
#define OUT_out_texCoord _TEXCOORD0_
#define OUT_wsNormal _TEXCOORD1_
#define OUT_outWsPosition _TEXCOORD2_
#define OUT_outVpos _TEXCOORD3_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float4x4 modelview      ;
uniform float4x4 objTrans       ;


void main()
{

   //-------------------------
   IN.position = vPosition;
   IN.normal = vNormal;
   IN.T = vTangent;
   IN.B = vBinormal;
   IN.texCoord = vTexCoord0;
   IN.texCoord2 = vTexCoord1;
   //-------------------------

   // Vert Position
   gl_Position = tMul(modelview, vec4(IN_position.xyz,1));
   
   // Base Texture
   OUT_out_texCoord = vec2(IN_texCoord);
   
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
