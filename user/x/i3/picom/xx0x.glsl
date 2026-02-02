#version 330
in vec2 texcoord;             // texture coordinate of the fragment
// uniform float corner_radius;  // corner radius of the window (pixels)
uniform float opacity;  
uniform float dim;  
uniform float border_width;  

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

    int corner_radius = 20;
    float borderWidth = 3.0;
    // float borderWidth = border_width; // Can't use this because picom gets the top as the border width 
    vec2 texSize = textureSize(tex, 0);

    vec2 offset= vec2(0.0, corner_radius);
    float sdf = sdRoundedBox(texcoord+offset, texSize+offset, corner_radius);

    if (sdf >= -borderWidth && sdf <= 0) {

      vec2 px = texcoord.xy;
      vec2 wh = texSize.xy;
      float halfheight = wh.y/2.0;
      float halfwidth = wh.x/2.0;

      ivec2 coords = ivec2(texSize.x/2, texSize.y - 1);

      if (px.x < halfwidth && ((abs(halfheight - px.y) <= halfheight - px.x) || px.y < halfheight))
      {
        coords = ivec2(1, texSize.y/2);
      } 
      else if (px.x > halfwidth && (halfheight - abs(halfheight - px.y) >= wh.x - px.x || px.y < halfheight)) 
      {
        coords = ivec2(texSize.x - 1, texSize.y/2);
      } 

      vec4 c = default_post_processing(vec4 (0.0, 0.0, 0.0, 0.0));
      c.rgb = texelFetch(tex, coords, 0).rgb;
      return c;
      // return vec4 (1.0, mod(sdf / borderWidth, 1.0), 1.0, 1.0);
    }

    if (sdf < 0.0) {
      // return vec4 (0.0, 1.0, 0.0, 1.0);
      return default_post_processing(color);
    }
    return default_post_processing(vec4(0.0, 0.0, 0.0, 0.0));
    return vec4(0.0, 0.0, 0.0, 0.0);
}
