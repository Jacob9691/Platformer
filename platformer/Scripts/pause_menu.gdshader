shader_type canvas_item;
uniform sampler2D SCREEN_TEXURE: hint_screen_texture, filter_linear_mipmap;

uniform float lod: hint_range(0.0, 5) = 0.0;

void fragment() {
	vec4 color = texture(SCREEN_TEXURE, SCREEN_UV, lod);
	COLOR = color;
}
