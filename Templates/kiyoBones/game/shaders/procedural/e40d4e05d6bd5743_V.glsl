//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// skybox
// Diffuse Color
// Reflect Cube
// Fog
// HDR Output
// Forward Shaded Material

struct VertexData
{
   vec3 position;
   vec3 normal;
   vec2 texCoord;
} IN;

in vec3 vPosition;
#define IN_position IN.position
in vec3 vNormal;
#define IN_normal IN.normal
in vec2 vTexCoord0;
#define IN_texCoord IN.texCoord

out vec3 _TEXCOORD0_;
out vec3 _TEXCOORD1_;

// Struct defines
#define OUT_reflectVec _TEXCOORD0_
#define OUT_outWsPosition _TEXCOORD1_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform float4x4 modelview      ;
uniform float4x4 objTrans       ;
uniform vec3     eyePosWorld    ;


void main()
{

   //-------------------------
   IN.position = vPosition;
   IN.normal = vNormal;
   IN.texCoord = vTexCoord0;
   //-------------------------

   // Vert Position
   gl_Position = tMul(modelview, vec4(IN_position.xyz,1));
   
   // skybox
   
   // Diffuse Color
   
   // Reflect Cube
   vec3 cubeVertPos = tMul( objTrans, float4(IN_position,1)).xyz;
   vec3 cubeNormal = ( tMul( (objTrans),  vec4(IN_normal, 0) ) ).xyz;
   cubeNormal = bool(length(cubeNormal)) ? normalize(cubeNormal) : cubeNormal;
   vec3 eyeToVert = cubeVertPos - eyePosWorld;
   OUT_reflectVec = reflect(eyeToVert, cubeNormal);
   
   // Fog
   OUT_outWsPosition = tMul( objTrans, vec4( IN_position.xyz, 1 ) ).xyz;
   
   // HDR Output
   
   // Forward Shaded Material
   
   gl_Position.y *= -1;
}
