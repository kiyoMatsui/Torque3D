//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Hardware Skinning
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
   vec4 vBlendIndex0;
   vec4 vBlendWeight0;
   vec4 vBlendIndex1;
   vec4 vBlendWeight1;
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
in vec4 vTexCoord2;
#define IN_vBlendIndex0 IN.vBlendIndex0
in vec4 vTexCoord6;
#define IN_vBlendWeight0 IN.vBlendWeight0
in vec4 vTexCoord3;
#define IN_vBlendIndex1 IN.vBlendIndex1
in vec4 vTexCoord7;
#define IN_vBlendWeight1 IN.vBlendWeight1

out vec4 _TEXCOORD0_;
out float4 _TEXCOORD1_;

// Struct defines
#define OUT_outVpos _TEXCOORD0_
#define OUT_wsEyeVec _TEXCOORD1_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform mat4x3   nodeTransforms [70];
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
   IN.vBlendIndex0 = vTexCoord2;
   IN.vBlendWeight0 = vTexCoord6;
   IN.vBlendIndex1 = vTexCoord3;
   IN.vBlendWeight1 = vTexCoord7;
   //-------------------------

   // Hardware Skinning
   vec3 posePos = vec3(0.0);
   vec3 poseNormal = vec3(0.0);
   mat4x3 poseMat;
   mat3x3 poseRotMat;
   int i;
   for (i=0; i<4; i++) {
      int poseIdx = int(IN_vBlendIndex0[i]);
      float poseWeight = IN_vBlendWeight0[i];
      poseMat = nodeTransforms[poseIdx];
      poseRotMat = mat3x3(poseMat);
      posePos += (poseMat * vec4(IN_position, 1)).xyz * poseWeight;
      poseNormal += ((poseRotMat * IN_normal) * poseWeight);
   }
   for (i=0; i<4; i++) {
      int poseIdx = int(IN_vBlendIndex1[i]);
      float poseWeight = IN_vBlendWeight1[i];
      poseMat = nodeTransforms[poseIdx];
      poseRotMat = mat3x3(poseMat);
      posePos += (poseMat * vec4(IN_position, 1)).xyz * poseWeight;
      poseNormal += ((poseRotMat * IN_normal) * poseWeight);
   }
   IN_position = posePos;
   IN_normal = normalize(poseNormal);
   
   // Vert Position
   gl_Position = tMul(modelview, vec4(IN_position.xyz,1));
   
   // Visibility
   OUT_outVpos = gl_Position;
   
   // Eye Space Depth (Out)
   float3 depthPos = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   OUT_wsEyeVec = float4( depthPos.xyz - eyePosWorld, 1 );
   
   gl_Position.y *= -1;
}
