cmake_minimum_required(VERSION 3.15)
project(DarkPlaces LANGUAGES C)

set(CMAKE_C_STANDARD 99)

# Common compiler options
if(MSVC)
    add_compile_options(/W3 /wd4996 /wd4244 /wd4267 /wd4305 /wd4018 /wd4101 /wd4245 /wd4133 /wd4047 /wd4013 /wd4100 /wd4204 /wd4706 /wd4201 /wd4701 /wd4703)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
else()
    add_compile_options(-Wall -Wno-unused -fno-strict-aliasing)
endif()

# Include dpdefs if present
if(IS_DIRECTORY "${CMAKE_SOURCE_DIR}/dpdefs")
    include_directories("${CMAKE_SOURCE_DIR}/dpdefs")
endif()

# Explicit common sources (matches makefile.inc OBJ_COMMON exactly)
set(COMMON_SOURCES
    bih.c
    cap_avi.c
    cap_ogg.c
    cd_shared.c
    crypto.c
    cl_collision.c
    cl_demo.c
    cl_dyntexture.c
    cl_input.c
    cl_main.c
    cl_parse.c
    cl_particles.c
    cl_screen.c
    cl_video.c
    clvm_cmds.c
    cmd.c
    collision.c
    common.c
    console.c
    csprogs.c
    curves.c
    cvar.c
    dpsoftrast.c
    dpvsimpledecode.c
    filematch.c
    fractalnoise.c
    fs.c
    ft2.c
    utf8lib.c
    gl_backend.c
    gl_draw.c
    gl_rmain.c
    gl_rsurf.c
    gl_textures.c
    hmac.c
    host.c
    host_cmd.c
    image.c
    image_png.c
    jpeg.c
    keys.c
    lhnet.c
    libcurl.c
    mathlib.c
    matrixlib.c
    mdfour.c
    menu.c
    meshqueue.c
    mod_skeletal_animatevertices_sse.c
    mod_skeletal_animatevertices_generic.c
    model_alias.c
    model_brush.c
    model_shared.c
    model_sprite.c
    mvm_cmds.c
    netconn.c
    palette.c
    polygon.c
    portals.c
    protocol.c
    prvm_cmds.c
    prvm_edict.c
    prvm_exec.c
    r_explosion.c
    r_lerpanim.c
    r_lightning.c
    r_modules.c
    r_shadow.c
    r_sky.c
    r_sprites.c
    sbar.c
    sv_demo.c
    sv_main.c
    sv_move.c
    sv_phys.c
    sv_user.c
    svbsp.c
    svvm_cmds.c
    sys_shared.c
    vid_shared.c
    view.c
    wad.c
    world.c
    zone.c
)

# Common sound sources
set(SND_COMMON_SOURCES
    snd_main.c
    snd_mem.c
    snd_mix.c
    snd_ogg.c
    snd_wav.c
    snd_modplug.c
)

# builddate.c
set(BUILDDATE_SOURCE builddate.c)

if(WIN32)
    # ==================== WINDOWS ====================
    # Bundled SDL2
    set(SDL2_PATH "${CMAKE_SOURCE_DIR}/dependencies/SDL2-2.32.10")
    include_directories("${SDL2_PATH}/include")
    link_directories("${SDL2_PATH}/lib/x64")

    # SDL client
    set(SDL_SOURCES
        cd_sdl.c
        snd_sdl.c
        sys_sdl.c
        thread_sdl.c
        vid_sdl.c
    )
    add_executable(darkplaces-sdl WIN32 ${COMMON_SOURCES} ${SND_COMMON_SOURCES} ${SDL_SOURCES} ${BUILDDATE_SOURCE} darkplaces.rc)
    target_link_libraries(darkplaces-sdl SDL2main SDL2 opengl32 winmm ws2_32 user32 gdi32 shell32 ole32 advapi32 comdlg32)
    target_compile_definitions(darkplaces-sdl PRIVATE WIN32)
    add_custom_command(TARGET darkplaces-sdl POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${SDL2_PATH}/lib/x64/SDL2.dll"
            $<TARGET_FILE_DIR:darkplaces-sdl>)

    # WGL client
    set(WGL_SOURCES
        cd_win.c
        snd_win.c
        sys_win.c
        thread_null.c
        vid_wgl.c
    )
    add_executable(darkplaces-wgl WIN32 ${COMMON_SOURCES} ${SND_COMMON_SOURCES} ${WGL_SOURCES} ${BUILDDATE_SOURCE} darkplaces.rc)
    target_link_libraries(darkplaces-wgl opengl32 winmm ws2_32 user32 gdi32 shell32 ole32 advapi32 comdlg32 dsound dxguid dinput8 comctl32)
    target_compile_definitions(darkplaces-wgl PRIVATE WIN32)

    # Dedicated server (headless GUI exe with AllocConsole() - NO conproc.c to avoid error 6)
    set(DEDICATED_SOURCES
        cd_null.c
        snd_null.c
        sys_win.c
        thread_null.c
        vid_null.c
        # conproc.c EXCLUDED - removes "error code 6" popup entirely
    )
    add_executable(darkplaces-dedicated WIN32 ${COMMON_SOURCES} ${DEDICATED_SOURCES} ${BUILDDATE_SOURCE} darkplaces.rc)
    target_link_libraries(darkplaces-dedicated winmm ws2_32 user32 gdi32 shell32 ole32)
    target_compile_definitions(darkplaces-dedicated PRIVATE WIN32 SERVERONLY)
    set_target_properties(darkplaces-dedicated PROPERTIES OUTPUT_NAME "darkplaces-dedicated")

else()
    # ==================== LINUX ====================
    find_package(SDL2 REQUIRED)
    include_directories(${SDL2_INCLUDE_DIRS})

    # Linux SDL client
    set(LINUX_SDL_SOURCES
        cd_sdl.c
        snd_sdl.c
        sys_linux.c
        thread_sdl.c
        vid_sdl.c
    )
    add_executable(darkplaces-sdl ${COMMON_SOURCES} ${SND_COMMON_SOURCES} ${LINUX_SDL_SOURCES} ${BUILDDATE_SOURCE})
    target_link_libraries(darkplaces-sdl ${SDL2_LIBRARIES} GL m pthread dl)
    target_compile_definitions(darkplaces-sdl PRIVATE LINUX)

    # Linux dedicated server (console/headless)
    set(LINUX_DEDICATED_SOURCES
        cd_null.c
        snd_null.c
        sys_linux.c
        thread_pthread.c
        vid_null.c
    )
    add_executable(darkplaces-dedicated ${COMMON_SOURCES} ${LINUX_DEDICATED_SOURCES} ${BUILDDATE_SOURCE})
    target_link_libraries(darkplaces-dedicated m pthread dl)
    target_compile_definitions(darkplaces-dedicated PRIVATE LINUX SERVERONLY)
endif()