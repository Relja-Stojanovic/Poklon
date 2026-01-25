shader_type canvas_item;

//uniform vec4 bottom_color : source_color = vec4(1.0, 0.1, 0.6, 1.0);
uniform float stripe_count = 40.0;
uniform float speed = 10;
uniform float stripe_thickness = 0.025;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 bottom_color = vec4(vec3(1.0, 1.0, 1.0) - tex.rgb, tex.a);
	
	float vertical_pos = (UV.y - REGION_RECT.y) / REGION_RECT.w;
	
	float time_scroll = TIME * speed;
	float stripe_logic = sin((vertical_pos + time_scroll) - (pow(vertical_pos, 2.0) * stripe_count));
    
	float stripe_mask = smoothstep(0.4, 0.9, vertical_pos);
 
	vec4 final_color = mix(tex, bottom_color, vertical_pos);

	float alpha = tex.a;
    
    if (stripe_logic > stripe_thickness) {
        alpha *= (1.0 - stripe_mask);
    }
    
    COLOR = vec4(final_color.rgb, alpha);
}