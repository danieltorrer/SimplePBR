package estudiolumen.simplepbr;

import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;
import processing.opengl.PShader;

/*This class extends the PBRMat class in order to use the single map version of the PBR shader where 
 * Metallness, roughness, ao and custom are combined into a single map where :
 * Red Channel : Metallic
 * Green Channel : Roughness
 * Blue Channel : Ambient Occlusion
 * Alpha Channel : Custom 1D map
 * */
public class PBRSMMat extends PBRMat{
	PImage mraocTex;
	
	public PBRSMMat() {
		metallic = 0;
		roughness = 1;
		rim = 0f;
		normalIntensity = 1f;
		setFragmentCustomShader("data/shaders/pbr/pbrsm.frag");
		albedoTex = SimplePBR.getWhiteTexture();
		normalTex = SimplePBR.getWhiteTexture();
		mraocTex = SimplePBR.getWhiteTexture();
	}
	
	public PBRSMMat(String path) {
		this();
		albedoTex = SimplePBR.getPapplet().loadImage(path+"albedo.png");
		normalTex = SimplePBR.getPapplet().loadImage(path+"normal.png");
		mraocTex = SimplePBR.getPapplet().loadImage(path+"mraocMap.png");
	}
	
	public PBRSMMat(PBRSMMat copy){
		this();
		metallic = copy.metallic;
		roughness = copy.roughness;
		rim = copy.rim;
		shader = copy.shader;
		albedoTex = copy.albedoTex;
		mraocTex = copy.mraocTex;
		normalTex = copy.normalTex;
	}
	
	@Override 
	public void bind(PGraphics pg){
		pg.resetShader();
		shader.set("normalMap", normalTex);
		shader.set("mraocMap", mraocTex);
		shader.set("albedoTex", albedoTex);	
		shader.set("material", metallic, roughness, normalIntensity, rim);
		pg.shader(shader);
	}
}
