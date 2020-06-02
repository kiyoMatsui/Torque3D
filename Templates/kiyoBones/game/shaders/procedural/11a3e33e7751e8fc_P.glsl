//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/torque.glsl"

// Features:
// Hardware Skinning
// Vert Position
// Base Texture
// Visibility
// Fog
// HDR Output
// Translucent
// Forward Shaded Material

in vec2 _TEXCOORD0_;
in vec3 _TEXCOORD1_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform sampler2D diffuseMap     ;
uniform float    visibility     ;
uniform vec4     fogColor       ;
uniform vec3     eyePosWorld    ;
uniform vec3     fogData        ;

void main()
{
   float visibility = visibility;
   vec4 fogColor = fogColor;
   vec3 eyePosWorld = eyePosWorld;
   vec3 fogData = fogData;

   //-------------------------
   vec2 IN_texCoord = _TEXCOORD0_;
   vec3 IN_wsPosition = _TEXCOORD1_;
   //-------------------------

   // Hardware Skinning
   
   // Vert Position
   
   // Base Texture
vec4 diffuseColor = tex2D(diffuseMap, IN_texCoord);
   diffuseColor = toLinear(diffuseColor);
   OUT_col = diffuseColor;
   
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
