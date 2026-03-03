
# Mesher Final - GPGPU Physics Simulation

![Intro Gif](Intro%20Gif.gif)

## Overview

This project is a GPU-accelerated physics simulation using instanced meshes, designed for beautiful, interactive visualizations ("wallpaper edition"). It leverages GPGPU techniques in WebGL via Three.js, allowing thousands of particles to move and interact in real time.


## Visual Examples

- ![Attract/Repell](Attract_Repell.gif) — Shows attract/repel particle behavior.
- ![Music Bar](Music%20Bar.gif) — Visualizes audio-reactive physics.
- ![Intro](Intro%20Gif.gif) — General system overview.

## Technical Details

### PhysicsRenderer

The core engine is the `PhysicsRenderer` ([lib/PhysicsRenderer.js](lib/PhysicsRenderer.js)), which:

- Uses floating-point textures to store particle positions and velocities.
- Runs physics updates in fragment shaders, using textures as data buffers.
- Requires a WebGL renderer (Three.js) and a simulation shader (GLSL fragment shader).

### Simulation Shaders

Physics logic is written in GLSL. Each simulation mode (curl, flocking, etc.) has its own shader in [shaders/](shaders/).

### Instanced Rendering

`InstanceMesh.js` and `Snake.js` create instanced geometries, allowing rendering of thousands of particles. Each instance fetches its position from the physics texture.

### ShaderLoader

`ShaderLoader.js` helps manage and inject GLSL code, making it easy to reuse functions (like noise) across shaders.

## How It Works

- **GPGPU:** Physics is computed for every particle using fragment shaders. Position and velocity are encoded as colors in floating-point textures.
- **Data Flow:** Each frame, the simulation shader updates positions/velocities, and the renderer displays the result.

## Tech Stack

| Technology | Role |
|---|---|
| **Three.js** | 3D rendering engine — handles scenes, cameras, materials, and the WebGL context |
| **WebGL** | Low-level browser graphics API that Three.js targets; enables GPU-accelerated rendering |
| **GLSL** | Shader language used for simulation logic (fragment shaders) and visual output (vertex/fragment shaders) |
| **JavaScript (ES5)** | Application logic, scene setup, animation loop, and user interaction |
| **jQuery** | DOM manipulation and event handling for UI controls |
| **HTML5 / CSS** | Page structure and styling |

## Credits

Inspired by:
- [Sporel by @mrdoob](http://mrdoob.com/#/153/sporel)
- [Soulwire's GPGPU Particles](http://soulwire.co.uk/experiments/webgl-gpu-particles/)

---
