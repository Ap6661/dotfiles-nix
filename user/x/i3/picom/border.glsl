#version 330
in vec2 texcoord;             // texture coordinate of the fragment
uniform float corner_radius;  // corner radius of the window (pixels)
uniform float opacity;  
uniform float dim;  

uniform sampler2D tex;        // texture of the window

// Default window post-processing:
// 1) invert color
// 2) opacity / transparency
// 3) max-brightness clamping
// 4) rounded corners
vec4 default_post_processing(vec4 c);

float sdRoundedBox(vec2 p, vec2 size, float radius) {
    vec2 halfSize = size * 0.5;
    vec2 q = abs(p - halfSize) - halfSize + radius;
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - radius;
}

vec4 window_shader() {
    // Fetch the pixel color
    // vec4 color = texture(tex, texcoord);
    vec4 color = texelFetch(tex, ivec2(texcoord), 0);

    float borderWidth = 5.0;
    vec2 texSize = textureSize(tex, 0);

    float sdf = sdRoundedBox(texcoord, texSize, corner_radius);

    if (sdf >= -borderWidth && sdf <= 0) {
      return default_post_processing(vec4(0.746094, 0.0, 0.746094, opacity) * (1 - dim));
    }
  
    // Apply default post-processing
    return default_post_processing(color);
}
