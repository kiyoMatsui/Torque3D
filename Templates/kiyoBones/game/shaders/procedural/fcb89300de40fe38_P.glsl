//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// Diffuse Color
// Diffuse Vertex Color
// Visibility
// Fog
// HDR Output
// Translucent
// Forward Shaded Material

in vec4 _COLOR_;
in vec3 _TEXCOORD0_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform vec4     diffuseMaterialColor;
uniform float    visibility     ;
uniform vec4     fogColor       ;
uniform vec3     eyePosWorld    ;
uniform vec3     fogData        ;

void main()
{
   vec4 diffuseMaterialColor = diffuseMaterialColor;
   float visibility = visibility;
   vec4 fogColor = fogColor;
   vec3 eyePosWorld = eyePosWorld;
   vec3 fogData = fogData;

   //-------------------------
   vec4 IN_vertColor = _COLOR_;
   vec3 IN_wsPosition = _TEXCOORD0_;
   //-------------------------

   // Vert Position
   
   // Diffuse Color
   OUT_col = diffuseMaterialColor;
   
   // Diffuse Vertex Color
   OUT_col *= IN_vertColor;
   
   // Visibility
   OUT_col.a *= visibility;
   
   // Fog
   float fogAmount = saturate( computeSceneFog( eyePosWorld, IN_wsPosition, fogData.r, fogData.g, fogData.b ) );
   OUT_col.rgb = lerp( fogColor.rgb, OUT_col.rgb, fogAmount );
   
   // HDR Output
   OUT_col = hdrEncode( OUT_col );
   
   // Translucent
   
   // Forward Shaded Material
   
   
}
