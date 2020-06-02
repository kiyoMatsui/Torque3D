//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Hardware Skinning
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
   vec2 texCoord2;
   vec4 diffuse;
   vec4 vBlendIndex0;
   vec4 vBlendWeight0;
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
in vec2 vTexCoord1;
#define IN_texCoord2 IN.texCoord2
in vec4 vColor;
#define IN_diffuse IN.diffuse
in vec4 vTexCoord2;
#define IN_vBlendIndex0 IN.vBlendIndex0
in vec4 vTexCoord6;
#define IN_vBlendWeight0 IN.vBlendWeight0

out vec2 _TEXCOORD0_;
out vec3 _TEXCOORD1_;

// Struct defines
#define OUT_out_texCoord _TEXCOORD0_
#define OUT_outWsPosition _TEXCOORD1_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform mat4x3   nodeTransforms [70];
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
   IN.texCoord2 = vTexCoord1;
   IN.diffuse = vColor;
   IN.vBlendIndex0 = vTexCoord2;
   IN.vBlendWeight0 = vTexCoord6;
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
   IN_position = posePos;
   IN_normal = normalize(poseNormal);
   
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
