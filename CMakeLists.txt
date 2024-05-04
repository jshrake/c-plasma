cmake_minimum_required(VERSION 3.13)
project(CPlasma VERSION 1.0.0 DESCRIPTION "C Plasma")

# Specify the C standard
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)

# Check dependencies
find_package(PkgConfig REQUIRED)
pkg_check_modules(YAML REQUIRED yaml-0.1) 

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

# Loam
add_library(loam STATIC
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
)
add_dependencies(loam copy_ob_vers_gen_h)
set(loam_headers 
    "plasma/libLoam/c/ob-atomic.h"
    "plasma/libLoam/c/ob-dirs.h"
    "plasma/libLoam/c/ob-file.h"
    "plasma/libLoam/c/ob-hash-city.h"
    "plasma/libLoam/c/ob-hash.h"
    "plasma/libLoam/c/ob-log.h"
    "plasma/libLoam/c/ob-math.h"
    "plasma/libLoam/c/ob-rand.h"
    "plasma/libLoam/c/ob-retorts.h"
    "plasma/libLoam/c/ob-string.h"
    "plasma/libLoam/c/ob-thread.h"
    "plasma/libLoam/c/ob-time.h"
    "plasma/libLoam/c/ob-truly-rand.h"
    "plasma/libLoam/c/ob-util.h"
    "plasma/libLoam/c/ob-vers.h"
)
set_target_properties(loam PROPERTIES PUBLIC_HEADER "${loam_headers}")
target_include_directories(loam PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/plasma>
    $<INSTALL_INTERFACE:include>
)

# Plasma
add_library(plasma STATIC
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
    "plasma/libPlasma/c/slaw-yaml-stub.c"
    "plasma/libPlasma/c/slaw-yaml.c"
    "plasma/libPlasma/c/slaw.c"
)
set(plasma_headers 
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
)
set_target_properties(plasma PROPERTIES PUBLIC_HEADER "${plasma_headers}")
target_include_directories(plasma PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/plasma>
    $<INSTALL_INTERFACE:include>
)

target_include_directories(plasma PRIVATE ${YAML_INCLUDE_DIRS})
target_link_libraries(plasma PRIVATE loam ${YAML_LIBRARIES})
target_compile_options(plasma PRIVATE ${YAML_CFLAGS_OTHER})

# Installation rules for library, headers, and binaries
install(TARGETS loam
    LIBRARY DESTINATION lib
    PUBLIC_HEADER DESTINATION include/libLoam/c
)
install(TARGETS plasma
    LIBRARY DESTINATION lib
    PUBLIC_HEADER DESTINATION include/libPlasma/c
)

# Binaries
function(add_bin exe_name source_file)
    add_executable(${exe_name} ${source_file})
    target_include_directories(${exe_name} PRIVATE ${YAML_INCLUDE_DIRS})
    target_link_libraries(${exe_name} PRIVATE loam plasma ${YAML_LIBRARIES})
    target_link_directories(${exe_name} PRIVATE ${YAML_LIBRARY_DIRS})
    target_compile_options(${exe_name} PRIVATE ${YAML_CFLAGS_OTHER})
    install(TARGETS ${exe_name} RUNTIME DESTINATION bin)
endfunction()

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

# # Configuration for pkg-config file
# configure_file(my_c_library.pc.in my_c_library.pc @ONLY)
# install(FILES ${CMAKE_BINARY_DIR}/my_c_library.pc DESTINATION lib/pkgconfig)