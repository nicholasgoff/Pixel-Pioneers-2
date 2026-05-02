varying vec2 v_vTexcoord;
varying vec4 v_vColour; 

uniform float u_intensity; 

void main() {
	vec4 texel = texture2D(gm_BaseTexture, v_vTexcoord); 
	
	float offset = 0.08 * u_intensity; 
	float a = texture2D(gm_BaseTexture, v_vTexcoord + vec2(offset, 0.0)).a 
			  + texture2D(gm_BaseTexture, v_vTexcoord + vec2(-offset, 0.0)).a
			  + texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, offset)).a
			  + texture2D(gm_BaseTexture, v_vTexcoord + vec2(0.0, -offset)).a;
			  
	if (texel.a < 0.1 && a > 0.5) {
		gl_FragColor = vec4(1.0, 0.0, 1.0, u_intensity); 
	} else { 
		gl_FragColor = v_vColour * texel;
	}
}