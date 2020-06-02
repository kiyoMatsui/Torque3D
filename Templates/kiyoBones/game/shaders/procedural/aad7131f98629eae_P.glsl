//*****************************************************************************
// Torque -- GLSL procedural shader
//*****************************************************************************
#include "shaders/common/gl/hlslCompat.glsl"

// Dependencies:
#include "shaders/common/gl/lighting.glsl"
#include "shaders/common/gl/torque.glsl"

// Features:
// Vert Position
// Diffuse Color
// RT Lighting
// Visibility
// Fog
// HDR Output
// Translucent
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
uniform vec3     eyePosWorld    ;
uniform vec4     inLightPos     [3];
uniform vec4     inLightInvRadiusSq;
uniform vec4     inLightColor   [4];
uniform vec4     inLightSpotDir [3];
uniform vec4     inLightSpotAngle;
uniform vec4     inLightSpotFalloff;
uniform float    specularPower  ;
uniform vec4     specularColor  ;
uniform vec4     ambient        ;
uniform float    visibility     ;
uniform vec4     fogColor       ;
uniform vec3     fogData        ;

void main()
{
   vec4 diffuseMaterialColor = diffuseMaterialColor;
   vec3 eyePosWorld = eyePosWorld;
   vec4 inLightPos[3] = inLightPos;
   vec4 inLightInvRadiusSq = inLightInvRadiusSq;
   vec4 inLightColor[4] = inLightColor;
   vec4 inLightSpotDir[3] = inLightSpotDir;
   vec4 inLightSpotAngle = inLightSpotAngle;
   vec4 inLightSpotFalloff = inLightSpotFalloff;
   float specularPower = specularPower;
   vec4 specularColor = specularColor;
   vec4 ambient = ambient;
   float visibility = visibility;
   vec4 fogColor = fogColor;
   vec3 fogData = fogData;

   //-------------------------
   vec3 IN_wsNormal = _TEXCOORD0_;
   vec3 IN_wsPosition = _TEXCOORD1_;
   //-------------------------

   // Vert Position
   
   // Diffuse Color
   OUT_col = diffuseMaterialColor;
   
   // RT Lighting
   IN_wsNormal = normalize( half3( IN_wsNormal ) );
   vec3 wsView = normalize( eyePosWorld - IN_wsPosition );
   vec4 rtShading; vec4 specular;
   compute4Lights( wsView, IN_wsPosition, IN_wsNormal, vec4( 1, 1, 1, 1 ),
      inLightPos, inLightInvRadiusSq, inLightColor, inLightSpotDir, inLightSpotAngle, inLightSpotFalloff, specularPower, specularColor,
      rtShading, specular );
   OUT_col *= vec4( rtShading.rgb + ambient.rgb, 1 );
   
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
