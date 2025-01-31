shader_type canvas_item;

uniform sampler2D hatch_texture;
uniform float hatch_scale = 1.0;

void light() {
	vec2 uv = UV * hatch_scale;
	uv = mod(uv, 1.0f);
	float result;
	float brightness = max(dot(NORMAL, LIGHT_DIRECTION), 0.0f);
	if (brightness > 0.50f) {
		brightness = 1.0f;
		result = 1.0f;
	} else if (brightness > 0.4f) {
		brightness = 0.66f;
		result = (1.0f - texture(hatch_texture, uv).b);
	} else if (brightness > 0.0f) {
		result = (1.0f - texture(hatch_texture, uv).g);
	} else {
		brightness = 0.0f;
		result = (1.0f - texture(hatch_texture, uv).r);
	}
		LIGHT = result * texture(TEXTURE, UV);
}