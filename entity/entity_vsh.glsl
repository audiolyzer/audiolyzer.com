#version 300 es
precision highp float;

in vec3 position;
in vec3 normal;
in vec2 uvs;

uniform mat4 transformation;
uniform mat4 projection;
uniform mat4 view;

uniform float renderdistance;

out float visibility;

out vec3 surfaceNormal;
out vec3 toLightVector;
out vec2 out_uvs;


void main() {
	vec4 worldPosition = transformation * vec4(position, 1.0);
	vec4 positionRelativeToCam = view * worldPosition;
	gl_Position = projection * positionRelativeToCam;

	surfaceNormal = (transformation * vec4(normal, 0.0)).xyz;
	toLightVector = vec3(2500.0, 10000.0, 5000.0) - worldPosition.xyz;
	out_uvs = uvs;

	visibility = clamp(length(positionRelativeToCam) / renderdistance, 0.0, 1.0);
}
