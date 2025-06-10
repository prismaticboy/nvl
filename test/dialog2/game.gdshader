shader_type canvas_item;

uniform float cutoff:hint_range(0.0, 1.0, 0.1);
uniform float smooth_size:hint_range(0.0, 1.0, 0.1);
uniform sampler2D mask;
void fragment() {
	float value = texture(mask,UV).r;
	float alpha = smoothstep(cutoff,cutoff+smooth_size,value*(1.0-smooth_size)+smooth_size);
	COLOR = vec4(COLOR.rgb,alpha);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
