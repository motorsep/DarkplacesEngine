About (from the original website, with minor edits for clarity purposes)
========================================================================
DarkPlaces is a Quake modification LordHavoc (aka LadyHavoc), LH for short, have built over the course of 6 years on and off experimenting, it got somewhat of an overhaul when the Quake engine source code was released, and LH began developing a custom OpenGL-only engine for it and other mods, which supports Windows WGL, SDL and Linux GLX, and has greatly improved graphics and image quality.
It can not easily be described, as it is simply an improved Quake, not a total conversion (yet, anyway).
The realism of shell casings falling to the floor, much improved bullet impacts, 32bit color alpha blended explosions, blood flying everywhere and sticking to the walls...
Behind the scenes the code has changed a great deal, LH was not content with the original QuakeC code, and LH have greatly changed the engine while maintaining compatibility with normal quake modifications.

For more details please visit original website of the project: https://icculus.org/twilight/darkplaces/

Why this fork
=============
This version of Darkplaces engine was shipped with Steel Storm: Burning Retribution and it retains all the goodies that are now gone from current version of Darkplaces engine hosted elsewhere on github. In addition (at the time of the initial commit), this fork contains improved SDL2 support and cmake to generate MSVC2022 solution.

Compiling on Windows
====================
At the time of the initial commit, only 64-bit binaries are supported. Clone this repo, run build-msvc2022.bat, go into build/ folder and open .sln file. Build as you normally would build. SDL2 dependencies are included.

Compiling on Linux
==================
Untested, but should be supported. Below is example for Ubuntu/Debian:

sudo apt update
sudo apt install libsdl2-dev libgl1-mesa-dev libcurl4-openssl-dev libogg-dev libvorbis-dev libmodplug-dev

mkdir build_linux && cd build_linux
cmake ..
make -j$(nproc)

License
=======
GPL2.0

Credits
=======
Original creators and contributors
