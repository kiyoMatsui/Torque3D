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

in vec3 _TEXCOORD0_;
in vec3 _TEXCOORD1_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform vec4     diffuseMaterialColor;
uniform samplerCube cubeMap        ;
uniform vec4     fogColor       ;
uniform vec3     eyePosWorld    ;
uniform vec3     fogData        ;

void main()
{
   vec4 diffuseMaterialColor = diffuseMaterialColor;
   vec4 fogColor = fogColor;
   vec3 eyePosWorld = eyePosWorld;
   vec3 fogData = fogData;

   //-------------------------
   vec3 IN_reflectVec = _TEXCOORD0_;
   vec3 IN_wsPosition = _TEXCOORD1_;
   //-------------------------

   // Vert Position
   
   // skybox
   
   // Diffuse Color
   OUT_col = diffuseMaterialColor;
   
   // Reflect Cube
   OUT_col *= texture( cubeMap, IN_reflectVec);
   
   // Fog
   float fogAmount = saturate( computeSceneFog( eyePosWorld, IN_wsPosition, fogData.r, fogData.g, fogData.b ) );
   OUT_col.rgb = lerp( fogColor.rgb, OUT_col.rgb, fogAmount );
   
   // HDR Output
   OUT_col = hdrEncode( OUT_col );
   
   // Forward Shaded Material
   
   
}
