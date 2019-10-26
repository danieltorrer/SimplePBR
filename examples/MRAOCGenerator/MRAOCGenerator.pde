/**
 * SimplePBR Basic use
 *
 * Combine various 1D textures inputs into 1 output inspired by Unity HDRP texture stack: https://blogs.unity3d.com/2018/09/24/the-high-definition-render-pipeline-getting-started-guide-for-artists/
 * The outputs are :
 * Red Channel : Metallic
 * Green Channel : Roughness
 * Blue Channel : Ambient Occlusion
 * Alpha Channel : Custom 1D map
 *
 * by Alexandre Rivaux 2019
 * www.bonjour-lab.com
 *
 */

import estudiolumen.simplepbr.*;

PShader generator;
PImage metalnessMap, roughnessMap, ambientOcclusionMap, customMap;
PGraphics mraocMap;

void setup() {

	String path = sketchPath("../data/");
	SimplePBR.init(this, path + "textures/cubemap/Zion_Sunsetpeek");

	metalnessMap 		= loadImage(path+"textures/material/Plaster/metalness.png");
	roughnessMap 		= loadImage(path+"textures/material/Plaster/roughness.png");
	ambientOcclusionMap = SimplePBR.getWhiteTexture();
	customMap 			= SimplePBR.getWhiteTexture();

	
	size(800, 400, P3D);

	mraocMap = createGraphics(metalnessMap.width, metalnessMap.height, P2D);
	generator = loadShader(path+"utils/mraoc.glsl");
	generator.set("metalnessMap", metalnessMap);
	generator.set("roughnessMap", roughnessMap);
	generator.set("ambientOcclusionMap", ambientOcclusionMap);
	generator.set("customMap", customMap);

	mraocMap.beginDraw();
	mraocMap.shader(generator);
	mraocMap.rect(0, 0, mraocMap.width, mraocMap.height);
	mraocMap.save("mraocMap.png");
	mraocMap.endDraw();
}

void draw() {
	background(127);
	image(metalnessMap, 0, 0, width/4, height/2);
	image(roughnessMap, width/4, 0, width/4, height/2);
	image(ambientOcclusionMap, 0,  height/2, width/4, height/2);
	image(customMap, width/4,  height/2, width/4, height/2);
	image(mraocMap, width/2,  0, width/2, height);
}
