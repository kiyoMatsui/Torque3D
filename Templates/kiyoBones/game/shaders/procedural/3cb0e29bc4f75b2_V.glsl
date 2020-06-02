//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Paraboloid Vert Transform
// Visibility
// Depth (Out)
// Single Pass Paraboloid

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

out float _TEXCOORD0_;
out float2 _TEXCOORD1_;
out vec4 _TEXCOORD2_;
out float _TEXCOORD3_;

// Struct defines
#define OUT_isBack _TEXCOORD0_
#define OUT_posXY _TEXCOORD1_
#define OUT_outVpos _TEXCOORD2_
#define OUT_depth _TEXCOORD3_

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform vec2     atlasScale     ;
uniform float4x4 worldViewOnly  ;
uniform vec4     lightParams    ;


void main()
{

   //-------------------------
   IN.position = vPosition;
   IN.tangentW = vTangentW;
   IN.normal = vNormal;
   IN.T = vTangent;
   IN.texCoord = vTexCoord0;
   //-------------------------

   // Paraboloid Vert Transform
   gl_Position = tMul(worldViewOnly, float4(IN_position.xyz,1)).xzyw;
   float L = length(gl_Position.xyz);
   bool isBack = gl_Position.z < 0.0;
   OUT_isBack = isBack ? -1.0 : 1.0;
   if ( isBack ) gl_Position.z = -gl_Position.z;
   gl_Position /= L;
   gl_Position.z = gl_Position.z + 1.0;
   gl_Position.xy /= gl_Position.z;
   gl_Position.z = L / lightParams.x;
   gl_Position.w = 1.0;
   OUT_posXY = gl_Position.xy;
   gl_Position.xy *= atlasScale.xy;
   gl_Position.x += isBack ? 0.5 : -0.5;
   
   // Visibility
   OUT_outVpos = gl_Position;
   
   // Depth (Out)
   OUT_depth = gl_Position.z / gl_Position.w;
   
   // Single Pass Paraboloid
   
   gl_Position.y *= -1;
}
