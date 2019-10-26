/**
 * SimplePBR use of Single Map for meytal, roughness, Ao and Custom
 *
 * by Alexandre Rivaux
 * www.bonjour-lab.com
 *
 */

import estudiolumen.simplepbr.*;

PShape lion;
PBRSMMat mat;

void setup() {
	size(800, 800, P3D);

	// Path to common data folder
	String path = sketchPath("../data/");

	lion = loadShape(path+"obj/Lion.obj");

	// Init SimplePBR providing path to folder with cubemap, radiance and irrandiance textures
	SimplePBR.init(this, path + "textures/cubemap/Zion_Sunsetpeek");
	SimplePBR.setExposure(1.4f); // simple exposure control

	// Create PBR materials from a set of textures
	mat = new PBRSMMat(path + "textures/material/Lion/");
	noStroke();
	lion.disableStyle();
}

void draw() {
	float nmx = norm(mouseX, 0, width);
	float nmy = norm(mouseY, 0, width);
	translate(width/2, height/2, 0);

  	SimplePBR.setDiffuseAttenuation(mat.getShader(), 1.0);
  	SimplePBR.setReflectionAttenuation(mat.getShader(), 0.25);

	// Draw a cube with the radiance textures as a blurry background
	noLights();
	rotateY(PI); // Just because I like more this side of the cube 
	// Additive blend to lighten the background, not really needed
	background(30);
	pointLight(255, 255, 255, 1000, 1000, 1000);
	pointLight(255, 255, 255, -1000, -1000, 1000);

	rotateY(frameCount * 0.01f);

	// sphere with no textures
	// In textureless material, roughness, metalness and color must be set manually like this
	mat.setRougness(0.85);
	mat.setMetallic(0.15);
	mat.setNormalIntensity(1.0);
	// mat.setRim(0.0);

	fill(20); //
	noStroke();
	mat.bind();
	scale(0.5);
	shape(lion);
}
