#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler2;
out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

float hash(float x) {
    return fract(sin(x) * 43758.5453);
}

void main() {
    float charIndex = gl_VertexID / 4;                                                                                  // default minecraft bullshit
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    if (0.995 < Color.r && Color.r < 1 && 0.995 < Color.g && Color.g < 1 && 0.995 < Color.b && Color.b < 1) {           // if color #fefefe then invis
        vertexColor.a = 0.0;
    }
    if (0.995 < Color.a && Color.a < 1) {                                                                               // wavy text (if a = FE)
        vertexColor.a = 1.0;
        gl_Position.y = gl_Position.y + sin(GameTime * 5000 + gl_Position.x * 50) / 100;                   
    }
    if (0.99 < Color.a && Color.a < 0.993) {                                                                            // shaky text (if a = FD)
        vertexColor.a = 1.0;
        float shakeIntensityX = 50;
        float shakeIntensityY = 100;
        float shakeSpeed = 5000;
        gl_Position.xy = gl_Position.xy + vec2(sin(GameTime * 43758.5453 + int(charIndex)), cos(GameTime * 43758.5453 + int(charIndex) * 43758.5453)) / 500;
    }
    texCoord0 = UV0;
}
