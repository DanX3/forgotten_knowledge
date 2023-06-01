shader_type canvas_item;

uniform sampler2D noise_tex;
uniform vec4 background : source_color;
uniform vec4 highlight : source_color;

const vec2 dir1 = vec2(-0.1, 0.35);
const vec2 dir2 = vec2(0.25, -0.08);

void fragment() {
	vec4 tex1 = texture(noise_tex, fract(0.2 * UV + 0.1 * TIME * dir1));
	vec4 tex2 = texture(noise_tex, fract(UV + tex1.rg - vec2(0.5)));
	tex2 =  vec4(1.0) - step(0.1, min(tex2, vec4(0.9)));
	COLOR = tex2;
	COLOR.a = step(2.99, COLOR.r + COLOR.g + COLOR.b);
	
	COLOR *= highlight;
	COLOR += step(0.1, 0.1 - (COLOR.r + COLOR.g + COLOR.b)) * background;
	
//	COLOR = 0.5 * (tex1 + tex2);
//	COLOR = tex1;
}
