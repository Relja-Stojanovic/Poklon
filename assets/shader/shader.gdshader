shader_type canvas_item;

uniform vec4 replace_color : source_color = vec4(1, 1, 1, 1);
uniform vec4 color_1 : source_color = vec4(1, 0, 0, 1);
uniform vec4 color_2 : source_color = vec4(0, 0, 1, 1);
uniform float speed = 1;
uniform float wave_scale = 1;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	
	if (replace_color == tex) {
		float t = (FRAGCOORD.x + FRAGCOORD.y) / wave_scale + TIME * speed;
		float wave = (sin(t) + 1.0) * 0.5;
		
		vec4 gradient = mix(color_1, color_2, wave);
		gradient.a = tex.a;
		COLOR = gradient;
	}
}
