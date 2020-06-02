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
// HDR Output
// Translucent
// Imposter
// Forward Shaded Material

in vec2 _TEXCOORD0_;

// Struct defines

//Fragment shader OUT
out vec4 OUT_col;


//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
uniform sampler2D diffuseMap     ;
uniform vec4     diffuseMaterialColor;
uniform float    visibility     ;

void main()
{
   vec4 diffuseMaterialColor = diffuseMaterialColor;
   float visibility = visibility;

   //-------------------------
   vec2 IN_texCoord = _TEXCOORD0_;
   //-------------------------

   // Hardware Skinning
   
   // Vert Position
   
   // Texture Animation
   
   // Base Texture
vec4 diffuseColor = tex2D(diffuseMap, IN_texCoord);
   OUT_col = diffuseColor;
   
   // Diffuse Color
   OUT_col *= diffuseMaterialColor;
   
   // Visibility
   OUT_col.a *= visibility;
   
   // HDR Output
   OUT_col = hdrEncode( OUT_col );
   
   // Translucent
   
   // Imposter
   
   // Forward Shaded Material
   
   
}
