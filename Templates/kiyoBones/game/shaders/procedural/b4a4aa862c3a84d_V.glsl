//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/lighting.glsl"
#include "shaders/common/gl/torque.glsl"

// Features:
// Hardware Skinning
// Vert Position
// Base Texture
// RT Lighting
// Visibility
// Fog
// HDR Output
// DXTnm
// Forward Shaded Material

struct VertexData
{
   vec3 position;
   float tangentW;
   vec3 normal;
   vec3 T;
   vec2 texCoord;
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
in vec2 vTexCoord0;
#define IN_texCoord IN.texCoord
in vec4 vTexCoord2;
#define IN_vBlendIndex0 IN.vBlendIndex0
in vec4 vTexCoord6;
#define IN_vBlendWeight0 IN.vBlendWeight0

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
uniform mat4x3   nodeTransforms [70];
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
   
   // Base Texture
   OUT_out_texCoord = vec2(IN_texCoord);
   
   // RT Lighting
   OUT_wsNormal = tMul( objTrans, vec4( normalize( IN_normal ), 0.0 ) ).xyz;
   OUT_outWsPosition = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   
   // Visibility
   OUT_outVpos = gl_Position;
   
   // Fog
   
   // HDR Output
   
   // DXTnm
   
   // Forward Shaded Material
   
   gl_Position.y *= -1;
}
