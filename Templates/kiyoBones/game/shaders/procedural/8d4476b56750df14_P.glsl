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
// Forward Shaded Material

in vec2 _TEXCOORD0_;
in vec3 _TEXCOORD1_;
in vec3 _TEXCOORD2_;
in vec4 _TEXCOORD3_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform sampler2D diffuseMap     ;
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
   vec2 IN_texCoord = _TEXCOORD0_;
   vec3 IN_wsNormal = _TEXCOORD1_;
   vec3 IN_wsPosition = _TEXCOORD2_;
   vec4 IN_inVpos = _TEXCOORD3_;
   //-------------------------

   // Hardware Skinning
   
   // Vert Position
   
   // Base Texture
vec4 diffuseColor = tex2D(diffuseMap, IN_texCoord);
   diffuseColor = toLinear(diffuseColor);
   OUT_col = diffuseColor;
   
   // RT Lighting
   IN_wsNormal = normalize( half3( IN_wsNormal ) );
   vec3 wsView = normalize( eyePosWorld - IN_wsPosition );
   vec4 rtShading; vec4 specular;
   compute4Lights( wsView, IN_wsPosition, IN_wsNormal, vec4( 1, 1, 1, 1 ),
      inLightPos, inLightInvRadiusSq, inLightColor, inLightSpotDir, inLightSpotAngle, inLightSpotFalloff, specularPower, specularColor,
      rtShading, specular );
   OUT_col *= vec4( rtShading.rgb + ambient.rgb, 1 );
   
   // Visibility
   vec2 vpos = IN_inVpos.xy / IN_inVpos.w;
   fizzle( vpos, visibility );
   
   // Fog
   float fogAmount = saturate( computeSceneFog( eyePosWorld, IN_wsPosition, fogData.r, fogData.g, fogData.b ) );
   OUT_col.rgb = lerp( fogColor.rgb, OUT_col.rgb, fogAmount );
   
   // HDR Output
   OUT_col = hdrEncode( OUT_col );
   
   // Forward Shaded Material
   
   
}
