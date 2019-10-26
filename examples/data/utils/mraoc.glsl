/*This shader combien various 1D texture inputs into 1 output inspired by Unity HDRP texture stack: https://blogs.unity3d.com/2018/09/24/the-high-definition-render-pipeline-getting-started-guide-for-artists/
The outputs are :
Red Channel : Metallic
Green Channel : Roughness
Blue Channel : Ambient Occlusion
Alpha Channel : Custom 1D map
*/

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D metalnessMap;
uniform sampler2D roughnessMap;
uniform sampler2D ambientOcclusionMap;
uniform sampler2D customMap;

in vec4 vertTexCoord;
out vec4 fragColor;

float luma(vec4 color) {
  return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}

void main(){
	vec2 uv         = vertTexCoord.xy;
	float metallic  = luma(texture(metalnessMap, uv));
	float roughness = luma(texture(roughnessMap, uv));
	float ao        = luma(texture(ambientOcclusionMap, uv));
	float custom    = luma(texture(customMap, uv));

	fragColor = vec4(metallic, roughness, ao, custom);
}
