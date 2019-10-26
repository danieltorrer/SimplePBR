/**
 * SimplePBR Basic use
 *
 * Move the mouse to modify center sphere's material
 *
 * by Nacho Cossio 2018
 * www.nachocossio.com (@nacho_cossio)
 *
 */

import estudiolumen.simplepbr.*;

PBRMat custommat, mat;
PImage displacementMap, mraocMap;

void setup() {
	size(800, 800, P3D);

	// Path to common data folder
	String path = sketchPath("../data/textures/");

	// Init SimplePBR providing path to folder with cubemap, radiance and irrandiance textures
	SimplePBR.init(this, path + "cubemap/Zion_Sunsetpeek");
	SimplePBR.setExposure(1.2f); // simple exposure control

	displacementMap = loadImage("noiseTexture.jpg");
	mraocMap = loadImage(path + "material/Plaster/mraocMap.png");

	mat = new PBRMat(path + "material/Plaster/");

	custommat = new PBRMat(path + "material/Plaster/");
	custommat.setCustomShader("vert.glsl", "frag.glsl");
	custommat.setTexture("mraoc", mraocMap);
	custommat.setTexture("displacementMap", displacementMap);

	sphereDetail(200);
	noStroke();
}

void draw() {
	float normMouseX = norm(mouseX, 0, width);
	float normMouseY = norm(mouseY, 0, height);

  	SimplePBR.setDiffuseAttenuation(custommat.getShader(), 1.0f);
  	SimplePBR.setReflectionAttenuation(custommat.getShader(), 0.25f);

	// Draw a cube with the radiance textures as a blurry background
	noLights();
	pushMatrix();
	translate(width/2, height/2, 0);
	rotateY(PI); // Just because I like more this side of the cube 
	// Additive blend to lighten the background, not really needed
	background(30);
	blendMode(ADD);
	SimplePBR.drawCubemap(g, 2000); 
	blendMode(BLEND);

	pointLight(255, 255, 255, 1000, 1000, 1000);
	pointLight(255, 255, 255, -1000, -1000, 1000);

	rotateY(frameCount * 0.005f);
	rotateX(frameCount * 0.0025f);

	// sphere with no textures
	// In textureless material, roughness, metalness and color must be set manually like this
	// custommat.setRougness(1.0f);
	// custommat.setMetallic(0.0f);
    custommat.setRim(0.15f);
	custommat.setFloat("displacementFactor", 50.0);
	custommat.setFloat("time", millis() * 0.0001);
	custommat.setNormalIntensity(0.25f);
	fill(255); 
	float radius = 150;

	pushMatrix();
	translate(-radius * 1.1, 0, 0);
	mat.bind();
	sphere(radius);
	popMatrix();
	
	pushMatrix();
	translate(radius * 1.1, 0, 0);
	custommat.bind();
	sphere(radius);
	popMatrix();

	popMatrix();

	resetShader();
	noLights();
	image(displacementMap, 0, 0, displacementMap.width * 0.25, displacementMap.height * 0.25);
}
