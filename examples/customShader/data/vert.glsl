#version 150

uniform mat4 transformMatrix;
uniform mat4 modelviewMatrix;
uniform mat3 normalMatrix;
uniform mat4 texMatrix;
uniform vec4 lightPosition[8];
uniform vec3 lightDiffuse[8];
uniform float time;

uniform sampler2D displacementMap;
uniform float displacementFactor = 0.0;

in vec4 position;
in vec4 color;
in vec3 normal;
in vec2 texCoord;
 
out FragData {
  vec4 color;
  vec4 vertex;
  vec3 ecVertex;
  vec3 normal;
  vec2 texCoord;
} FragOut;

float luma(vec4 color) {
  return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}

void main() {
  
  FragOut.texCoord = (texMatrix * vec4(texCoord, 1.0, 1.0)).st;
  FragOut.normal = normalize(normalMatrix * normal);
  
  vec4 dv = texture2D(displacementMap, FragOut.texCoord);
  float df = luma(dv);
  df = fract(df + sin((df + time) * 3.1415 * 4.0) * 0.1);
  vec4 dp = vec4(FragOut.normal * df * displacementFactor, 0.0) + position;

  gl_Position = transformMatrix * dp;
  FragOut.vertex = transformMatrix * dp;
  vec3 ecp = vec3(modelviewMatrix * dp);
  FragOut.ecVertex = ecp;
  FragOut.color =  color;
}