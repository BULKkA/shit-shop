shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear;

uniform float contrast : hint_range(0.8, 1.4) = 1.08;
uniform float saturation : hint_range(0.0, 1.5) = 1.08;
uniform float warmth : hint_range(0.0, 0.2) = 0.045;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.22;
uniform float grain_strength : hint_range(0.0, 0.08) = 0.012;


float random_noise(vec2 position) {
	return fract(sin(dot(position, vec2(12.9898, 78.233))) * 43758.5453);
}


void fragment() {
	vec4 source = texture(screen_texture, SCREEN_UV);
	vec3 color = source.rgb;

	color = (color - 0.5) * contrast + 0.5;

	float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));
	color = mix(vec3(luminance), color, saturation);

	color *= vec3(1.0 + warmth, 1.0 + warmth * 0.2, 1.0 - warmth);

	vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;
	float edge = smoothstep(0.55, 1.35, length(centered_uv));
	color *= 1.0 - edge * vignette_strength;

	float grain = random_noise(SCREEN_UV * vec2(1920.0, 1080.0) + fract(TIME) * 37.0);
	color += (grain - 0.5) * grain_strength;

	COLOR = vec4(clamp(color, 0.0, 1.0), source.a);
}
