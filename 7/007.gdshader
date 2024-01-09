shader_type spatial;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D NORMAL_TEXTURE : hint_normal_roughness_texture, filter_linear_mipmap;
uniform sampler2D DEPTH_TEXTURE : source_color, hint_depth_texture;

uniform sampler2D NOISE_MIXER : repeat_enable;
uniform sampler2D BARRELL; 
uniform sampler2D FADE : repeat_enable;


uniform float depth_range:hint_range(0.1, 100.0, 0.1);

void vertex(){
	POSITION = vec4(VERTEX, 1.0);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	
	vec3 screen_color = texture(SCREEN_TEXTURE, uv).rgb;
	vec3 noise_color = texture(NOISE_MIXER, uv).rgb;
	vec3 barrell_color = texture(BARRELL, uv).rgb;
	vec3 fade_color = texture(FADE, uv).rgb;
	
	vec3 normal = texture(NORMAL_TEXTURE, uv).rgb;
	float roughness =  texture(NORMAL_TEXTURE, uv).w;
	
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).x;
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z / depth_range;
	
	// your code goes here!
	
	
	// example outputs
	
	//ALBEDO = vec3(linear_depth); 	// showing depth texture
	//ALBEDO = normal; 				// showing normal texture
	//ALBEDO = vec3(roughness); 	// showing roughness texture
	vec3 blood_filter = screen_color;
	blood_filter.g = 0.0;
	blood_filter.b= 0.0;
	vec2 vert_scroll = vec2(SCREEN_UV.x,SCREEN_UV.y - (TIME/10.));
	noise_color = texture(NOISE_MIXER,vert_scroll).rgb;
	
	blood_filter = mix(screen_color, blood_filter, fade_color);
	
	ALBEDO = mix(screen_color, blood_filter,noise_color)*barrell_color;		// showing screen texture
}












