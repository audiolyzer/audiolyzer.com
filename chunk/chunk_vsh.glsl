#version 300 es
precision mediump float;

in vec3 position;

uniform mat4 transformation;
uniform mat4 projection;
uniform mat4 view;

uniform float renderdistance;

out float visibility;

out vec3 toLightVector;
out vec3 pass_position;

void main(void){

	vec4 worldPosition = transformation * vec4(position, 1.0);
	vec4 positionRelativeToCam = view * worldPosition;
	gl_Position = projection * positionRelativeToCam;

	toLightVector = vec3(250.0, 1000.0, 500.0) - worldPosition.xyz;
	pass_position = position;

	visibility = clamp(length(positionRelativeToCam) / renderdistance, 0.0, 1.0);
}
