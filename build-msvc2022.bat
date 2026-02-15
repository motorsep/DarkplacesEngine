@echo off
echo Checking for bundled SDL2...
if not exist "dependencies\SDL2-2.32.10" (
    echo ERROR: SDL2 not found! Place the VC devel package in dependencies\SDL2-2.32.10
    pause
    exit /b 1
)

echo Creating build directory...
if not exist build mkdir build
cd build

echo Generating Visual Studio 2022 solution (x64)...
cmake .. -G "Visual Studio 17 2022" -A x64

echo.
echo Generation complete! Open build\DarkPlaces.sln in Visual Studio.
echo Build "Release" configuration for best performance.
echo SDL2.dll will be copied automatically to the output folder for darkplaces-sdl.
pause