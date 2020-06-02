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

struct VertexData
{
   vec3 position;
   float tangentW;
   vec3 normal;
   vec3 T;
   vec2 texCoord;
   float4 inst_objectTrans[4];
   float inst_visibility;
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
in float4 vTexCoord1;
in float4 vTexCoord2;
in float4 vTexCoord3;
in float4 vTexCoord4;
#define IN_inst_objectTrans IN.inst_objectTrans
in float vTexCoord5;
#define IN_inst_visibility IN.inst_visibility

out float _TEXCOORD0_;
out vec4 _TEXCOORD1_;
out float4 _TEXCOORD2_;

// Struct defines
#define OUT_visibility _TEXCOORD0_
#define OUT_outVpos _TEXCOORD1_
#define OUT_wsEyeVec _TEXCOORD2_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float4x4 viewProj       ;
uniform float3   eyePosWorld    ;


void main()
{

   //-------------------------
   IN.position = vPosition;
   IN.tangentW = vTangentW;
   IN.normal = vNormal;
   IN.T = vTangent;
   IN.texCoord = vTexCoord0;
   IN.inst_objectTrans[0] = vTexCoord1;
   IN.inst_objectTrans[1] = vTexCoord2;
   IN.inst_objectTrans[2] = vTexCoord3;
   IN.inst_objectTrans[3] = vTexCoord4;
   IN.inst_visibility = vTexCoord5;
   //-------------------------

   // Vert Position
   mat4x4 objTrans = mat4x4( // Instancing!
      IN_inst_objectTrans[0],
      IN_inst_objectTrans[1],
      IN_inst_objectTrans[2],
      IN_inst_objectTrans[3] );
   float4x4 modelview = tMul( viewProj, objTrans ); // Instancing!
   gl_Position = tMul(modelview, vec4(IN_position.xyz,1));
   
   // Visibility
   OUT_visibility = IN_inst_visibility; // Instancing!
   OUT_outVpos = gl_Position;
   
   // Eye Space Depth (Out)
   float3 depthPos = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   OUT_wsEyeVec = float4( depthPos.xyz - eyePosWorld, 1 );
   
   // Hardware Instancing
   
   gl_Position.y *= -1;
}
