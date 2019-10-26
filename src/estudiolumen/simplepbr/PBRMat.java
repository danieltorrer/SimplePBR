package estudiolumen.simplepbr;

import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;
import processing.opengl.PShader;

public class PBRMat {
	PShader shader;
	PImage albedoTex, metallicTex, roughnessTex, normalTex;
	float metallic;
	float roughness;
	float rim;
	float normalIntensity;
		
	public PBRMat(){
		metallic = 0;
		roughness = 1;
		rim = 0f;
		normalIntensity = 1f;
		shader = SimplePBR.getPbrShader();
		albedoTex = SimplePBR.getWhiteTexture();
		metallicTex = SimplePBR.getWhiteTexture();
		roughnessTex = SimplePBR.getWhiteTexture();
		normalTex = SimplePBR.getWhiteTexture();
	}
	
	public PBRMat( String path){
		this();
		albedoTex = SimplePBR.getPapplet().loadImage(path+"albedo.png");
		metallicTex = SimplePBR.getPapplet().loadImage(path+"metalness.png");
		roughnessTex = SimplePBR.getPapplet().loadImage(path+"roughness.png");
		normalTex = SimplePBR.getPapplet().loadImage(path+"normal.png");
	}
	
	public PBRMat(PBRMat copy){
		this();
		metallic = copy.metallic;
		roughness = copy.roughness;
		rim = copy.rim;
		shader = copy.shader;
		albedoTex = copy.albedoTex;
		metallicTex = copy.metallicTex;
		roughnessTex = copy.roughnessTex;
		normalTex = copy.normalTex;
	}
	
	public void bind(){
		bind(SimplePBR.getPapplet().g);
	}
	
	public void bind(PGraphics pg){
		pg.resetShader();
		shader.set("normalMap", normalTex);
		shader.set("roughnessMap", roughnessTex);
		shader.set("metalnessMap", metallicTex);
		shader.set("albedoTex", albedoTex);	
		shader.set("material", metallic, roughness, normalIntensity, rim);
		pg.shader(shader);
	}
	

	public PShader getShader() {
		return shader;
	}

	public PBRMat setShader(PShader shader) {
		this.shader = shader;
		return this;
	}
	
	public float getMetallic() {
		return metallic;
	}

	public PBRMat setMetallic(float metallic) {
		this.metallic = metallic;
		return this;
	}

	public float getRougness() {
		return roughness;
	}

	public PBRMat setRougness(float rougness) {
		this.roughness = rougness;
		return this;
	}

	public float getRim() {
		return rim;
	}

	public PBRMat setRim(float rim) {
		this.rim = rim;
		return this;
	}
	
	public float getNormalIntensity() {
		return normalIntensity;
	}

	public PBRMat setNormalIntensity(float normalIntensity) {
		this.normalIntensity = normalIntensity;
		return this;
	}
	
	
	public PBRMat setFloat(String name, float value) {
		shader.set("name", value);
		return this;
	}
	
	public PBRMat setVector(String name, float x, float y, float z) {
		shader.set("name", x, y, z);
		return this;
	}
	
	public PBRMat setTexture(String name, PImage texture) {
		shader.set("name", texture);
		return this;
	}
}
