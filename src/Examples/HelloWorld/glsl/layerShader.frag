#extension GL_ARB_texture_rectangle : enable
uniform sampler2DRect src_tex_unit0;
uniform sampler2D tex;
uniform float contrast;
uniform float brightness;
uniform float saturation;
uniform float blurH;
uniform float blurV;
uniform float redTint;
uniform float greenTint;
uniform float blueTint;


void main()
{
	vec2 st = gl_TexCoord[0].st;

	// apply blur
	vec4 color1;
	color1 = vec4(0,0,0,0);

	color1		+= 1.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * -4.0, 0.0));
	color1		+= 2.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * -3.0, 0.0));
	color1		+= 3.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * -2.0, 0.0));
	color1		+= 4.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * -1.0, 0.0));	
	color1		+= 5.0 * texture2DRect(src_tex_unit0, st + vec2(blurH, 0));
	color1		+= 4.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * 1.0, 0.0));
	color1		+= 3.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * 2.0, 0.0));
	color1		+= 2.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * 3.0, 0.0));
	color1		+= 1.0 * texture2DRect(src_tex_unit0, st + vec2(blurH * 4.0, 0.0));
	color1 /= 25.0;
	
	
	vec4 color2;
	color2 = vec4(0,0,0,0);
	color2		+= 1.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * 4.0));
	color2		+= 2.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * 3.0));
	color2		+= 3.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * 2.0));
	color2		+= 4.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * 1.0));	
	color2		+= 5.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV) );	
	color2		+= 4.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * -1.0));
	color2		+= 3.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * -2.0));
	color2		+= 2.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * -3.0));
	color2		+= 1.0 * texture2DRect(src_tex_unit0, st + vec2(0.0, blurV * -4.0));
	color2 /= 25.0;		

	vec3 color3;
	color3 = mix(vec3(color1[0], color1[1],color1[2]), vec3(color2[0], color2[1],color2[2]), 0.5);
	

	




	//vec4 color1 = texture2DRect(src_tex_unit0, gl_TexCoord[0].st);
	
	
	
	//vec3 color3 = vec3(color1[0], color1[1], color1[2]);
	const float AvgLumR = 0.5;
	const float AvgLumG = 0.5;
	const float AvgLumB = 0.5;
	
	const vec3 LumCoeff = vec3(0.2125, 0.7154, 0.0721);

	vec3 AvgLumin = vec3(AvgLumR, AvgLumG, AvgLumB);
	vec3 brtColor = color3 * brightness;
	
	vec3 intensity = vec3(dot(brtColor, LumCoeff));
	vec3 satColor = mix(intensity, brtColor, saturation);
	vec3 conColor = mix(AvgLumin, satColor, contrast);

		
	// apply the tints
	conColor[0] = conColor[0] * redTint;
	conColor[1] = conColor[1] * greenTint;
	conColor[2] = conColor[2] * blueTint;
	
	
	gl_FragColor = vec4(conColor,1);

}
