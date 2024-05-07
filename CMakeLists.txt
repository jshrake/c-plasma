cmake_minimum_required(VERSION 3.26)
project(CPlasma VERSION 1.0.0 DESCRIPTION "C Plasma")

# Specify the C standard
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)

set(CMAKE_INSTALL_BINDIR bin)
set(CMAKE_INSTALL_LIBDIR lib)
set(CMAKE_INSTALL_INCLUDEDIR include)

option(BUILD_BINS "Build the executables" ON)
option(YAML_SUPPORT "Build with YAML support" ON)

# Check dependencies
if (YAML_SUPPORT)
find_package(PkgConfig REQUIRED)
pkg_check_modules(YAML REQUIRED yaml-0.1) 
endif()

# Copy ob-vers-gen.h into place
set(SRC_FILE ${CMAKE_SOURCE_DIR}/generated/ob-vers-gen.h)
set(DST_FILE ${CMAKE_SOURCE_DIR}/plasma/libLoam/c/ob-vers-gen.h)
add_custom_command(
    OUTPUT ${DST_FILE}
    COMMAND ${CMAKE_COMMAND} -E copy ${SRC_FILE} ${DST_FILE}
    DEPENDS ${SRC_FILE}
    COMMENT "Copying ob-vers-gen.h"
)
add_custom_target(copy_ob_vers_gen_h ALL
    DEPENDS ${DST_FILE}
)

# Plasma
set(plasma_source
    # loam
    "plasma/libLoam/c/dSFMT.c"
    "plasma/libLoam/c/ob-atomic.c"
    "plasma/libLoam/c/ob-dirs.c"
    "plasma/libLoam/c/ob-file.c"
    "plasma/libLoam/c/ob-hash-city.c"
    "plasma/libLoam/c/ob-hash.c"
    "plasma/libLoam/c/ob-log.c"
    "plasma/libLoam/c/ob-math.c"
    "plasma/libLoam/c/ob-rand.c"
    "plasma/libLoam/c/ob-retorts.c"
    "plasma/libLoam/c/ob-string.c"
    "plasma/libLoam/c/ob-thread.c"
    "plasma/libLoam/c/ob-time.c"
    "plasma/libLoam/c/ob-truly-rand.c"
    "plasma/libLoam/c/ob-util.c"
    "plasma/libLoam/c/ob-vers.c"
    # plasma
    "plasma/libPlasma/c/eintr-helper.c"
    "plasma/libPlasma/c/fifo_ops.c"
    "plasma/libPlasma/c/nossl.c"
    "plasma/libPlasma/c/ob-lsfd.c"
    "plasma/libPlasma/c/plasma-util.c"
    "plasma/libPlasma/c/pool_cmd.c"
    "plasma/libPlasma/c/pool_mmap.c"
    "plasma/libPlasma/c/pool_multi.c"
    "plasma/libPlasma/c/pool_net.c"
    "plasma/libPlasma/c/pool_options.c"
    "plasma/libPlasma/c/pool_tcp.c"
    "plasma/libPlasma/c/pool-context.c"
    "plasma/libPlasma/c/pool-fifo.c"
    "plasma/libPlasma/c/pool-flock-ops.c"
    "plasma/libPlasma/c/pool-lock-ops.c"
    "plasma/libPlasma/c/pool-log.c"
    "plasma/libPlasma/c/pool-mmap-header.c"
    "plasma/libPlasma/c/pool-portable.c"
    "plasma/libPlasma/c/pool-toc.c"
    "plasma/libPlasma/c/pool.c"
    "plasma/libPlasma/c/protein.c"
    "plasma/libPlasma/c/sem_ops.c"
    "plasma/libPlasma/c/slaw-coerce.c"
    "plasma/libPlasma/c/slaw-concat.c"
    "plasma/libPlasma/c/slaw-interop.c"
    "plasma/libPlasma/c/slaw-io-convenience.c"
    "plasma/libPlasma/c/slaw-io-file.c"
    "plasma/libPlasma/c/slaw-io.c"
    "plasma/libPlasma/c/slaw-numerics.c"
    "plasma/libPlasma/c/slaw-ordering.c"
    "plasma/libPlasma/c/slaw-path.c"
    "plasma/libPlasma/c/slaw-string.c"
    "plasma/libPlasma/c/slaw-v1.c"
    "plasma/libPlasma/c/slaw-walk.c"
    "plasma/libPlasma/c/slaw.c"
)

if (YAML_SUPPORT)
list(APPEND plasma_source "plasma/libPlasma/c/slaw-yaml.c")
else()
list(APPEND plasma_source "plasma/libPlasma/c/slaw-yaml-stub.c")
endif()

set(loam_headers 
    # loam
    "plasma/libLoam/c/ob-api.h"
    "plasma/libLoam/c/ob-atomic.h"
    "plasma/libLoam/c/ob-attrs.h"
    "plasma/libLoam/c/ob-coretypes.h"
    "plasma/libLoam/c/ob-dirs.h"
    "plasma/libLoam/c/ob-file.h"
    "plasma/libLoam/c/ob-hash.h"
    "plasma/libLoam/c/ob-log.h"
    "plasma/libLoam/c/ob-math.h"
    "plasma/libLoam/c/ob-mvtypes.h"
    "plasma/libLoam/c/ob-rand.h"
    "plasma/libLoam/c/ob-retorts.h"
    "plasma/libLoam/c/ob-string.h"
    "plasma/libLoam/c/ob-thread.h"
    "plasma/libLoam/c/ob-time.h"
    "plasma/libLoam/c/ob-types.h"
    "plasma/libLoam/c/ob-util.h"
    "plasma/libLoam/c/ob-vers.h"
)
set(plasma_headers
    # plasma
    "plasma/libPlasma/c/c-plasma.h"
    "plasma/libPlasma/c/slaw.h"
    "plasma/libPlasma/c/protein.h"
    "plasma/libPlasma/c/pool.h"
    "plasma/libPlasma/c/pool-time.h"
    "plasma/libPlasma/c/pool_options.h"
    "plasma/libPlasma/c/slaw-coerce.h"
    "plasma/libPlasma/c/slaw-io.h"
    "plasma/libPlasma/c/slaw-ordering.h"
    "plasma/libPlasma/c/slaw-path.h"
    "plasma/libPlasma/c/slaw-string.h"
    "plasma/libPlasma/c/slaw-walk.h"
    "plasma/libPlasma/c/plasma-types.h"
    "plasma/libPlasma/c/plasma-retorts.h"
    "plasma/libPlasma/c/slaw-numeric-ilk-rumpus.h"
)

# Create a file_set to copy headers into place, preserving the directory structure
add_library(plasma STATIC ${plasma_source})
target_sources(plasma PUBLIC
    FILE_SET public_headers
    TYPE HEADERS
    BASE_DIRS plasma
    FILES ${plasma_headers} ${loam_headers}
)


add_dependencies(plasma copy_ob_vers_gen_h)
if (YAML_SUPPORT)
target_include_directories(plasma PRIVATE ${YAML_INCLUDE_DIRS})
target_link_libraries(plasma PRIVATE ${YAML_LIBRARIES})
target_compile_options(plasma PRIVATE ${YAML_CFLAGS_OTHER})
endif()


# Installation 
install(TARGETS plasma
    LIBRARY DESTINATION lib
    FILE_SET public_headers
)
install(FILES ${CMAKE_SOURCE_DIR}/apple/module.modulemap DESTINATION include)

# Pkg-config
configure_file(pkgconfig/plasma.pc.in plasma.pc @ONLY)
install(FILES ${CMAKE_BINARY_DIR}/plasma.pc DESTINATION lib/pkgconfig)


# Binaries
function(add_bin exe_name source_file)
    add_executable(${exe_name} ${source_file})
    if (YAML_SUPPORT)
    target_include_directories(${exe_name} PRIVATE ${YAML_INCLUDE_DIRS})
    target_link_directories(${exe_name} PRIVATE ${YAML_LIBRARY_DIRS})
    target_link_libraries(${exe_name} PRIVATE plasma ${YAML_LIBRARIES})
    target_compile_options(${exe_name} PRIVATE ${YAML_CFLAGS_OTHER})
    endif()
    install(TARGETS ${exe_name} RUNTIME DESTINATION bin)
endfunction()

if (BUILD_BINS)
add_bin(pool_tcp_server plasma/libPlasma/c/pool_tcp_server.c)
add_bin(p-await         plasma/libPlasma/c/p-await.c)
add_bin(p-create        plasma/libPlasma/c/p-create.c)
add_bin(p-deposit       plasma/libPlasma/c/p-deposit.c)
add_bin(p-info          plasma/libPlasma/c/p-info.c)
add_bin(p-newest-idx    plasma/libPlasma/c/p-newest-idx.c)
add_bin(p-nth           plasma/libPlasma/c/p-nth.c)
add_bin(p-oldest-idx    plasma/libPlasma/c/p-oldest-idx.c)
add_bin(p-rename        plasma/libPlasma/c/p-rename.c)
add_bin(p-resize        plasma/libPlasma/c/p-resize.c)
add_bin(p-sleep         plasma/libPlasma/c/p-sleep.c)
add_bin(p-stop          plasma/libPlasma/c/p-stop.c)
endif()