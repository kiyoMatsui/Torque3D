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

out vec4 _TEXCOORD0_;
out float4 _TEXCOORD1_;

// Struct defines
#define OUT_outVpos _TEXCOORD0_
#define OUT_wsEyeVec _TEXCOORD1_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float4x4 modelview      ;
uniform float4x4 objTrans       ;
uniform float3   eyePosWorld    ;


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
   
   // Visibility
   OUT_outVpos = gl_Position;
   
   // Eye Space Depth (Out)
   float3 depthPos = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   OUT_wsEyeVec = float4( depthPos.xyz - eyePosWorld, 1 );
   
   gl_Position.y *= -1;
}
