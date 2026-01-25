varying vec3 vNorm;
varying vec2 vLookup;

uniform float colorMode;

// HSV to RGB conversion
vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(){

  // Normal-based coloring (original)
  vec3 normalCol = vNorm * .5 + .5;
  
  // Chinatown neon palette - hot pink, red, orange, cyan accents
  vec3 hotPink = vec3(1.0, 0.1, 0.5);
  vec3 neonRed = vec3(1.0, 0.05, 0.15);
  vec3 neonOrange = vec3(1.0, 0.4, 0.1);
  vec3 neonCyan = vec3(0.1, 0.9, 0.95);
  vec3 neonMagenta = vec3(0.95, 0.1, 0.8);
  
  // Create color variation based on position
  float t = fract(vLookup.x * 5.0 + vLookup.y * 3.0);
  
  vec3 neonCol;
  if (t < 0.25) {
    neonCol = mix(hotPink, neonRed, t * 4.0);
  } else if (t < 0.5) {
    neonCol = mix(neonRed, neonOrange, (t - 0.25) * 4.0);
  } else if (t < 0.75) {
    neonCol = mix(neonOrange, neonMagenta, (t - 0.5) * 4.0);
  } else {
    neonCol = mix(neonMagenta, neonCyan, (t - 0.75) * 4.0);
  }
  
  // Add neon glow effect - bloom the colors
  float glow = 0.15 + 0.1 * sin(vLookup.x * 20.0 + vLookup.y * 15.0);
  neonCol = neonCol + glow;
  neonCol = clamp(neonCol, 0.0, 1.0);
  
  // Boost saturation and add slight bloom
  neonCol = pow(neonCol, vec3(0.85));
  
  // Mix between normal and neon based on colorMode uniform
  vec3 col = mix(normalCol, neonCol, colorMode);
  
  gl_FragColor = vec4( col , 1. ); 

}
