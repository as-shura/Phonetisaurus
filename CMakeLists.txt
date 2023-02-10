cmake_minimum_required(VERSION 3.8.2)

project(Phonetisaurus VERSION 1.0.0)

find_package(ZLIB REQUIRED)
# Find includes in the build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(HEADERS
    include/ARPA2WFST.h
    include/LatticePruner.h
    include/LegacyRnnLMDecodable.h
    include/LegacyRnnLMHash.h
    include/M2MFstAligner.h
    include/PhonetisaurusRex.h
    include/PhonetisaurusScript.h
    include/RnnLMDecoder.h
    include/RnnLMPy.h
    include/util.h

)

set(SRCS
    src/feature-reader.cc
    src/LatticePruner.cc
    src/M2MFstAligner.cc
    src/util.cc
)

# Tell CMake to create the helloworld executable
add_library(Phonetisaurus ${SRCS} ${HEADERS})

include(cmake/ExternalDeps.cmake)

include_directories(include)

# Add the Qt5 Widgets for linking
target_link_libraries(Phonetisaurus ZLIB::ZLIB)

if (MSVC)
    target_compile_options(Phonetisaurus PRIVATE /bigobj)
else ()
    target_compile_options(Phonetisaurus PRIVATE -Wa,-mbig-obj)
endif ()

export(TARGETS Phonetisaurus NAMESPACE Phonetisaurus:: FILE PhonetisaurusTargets.cmake)

install(TARGETS Phonetisaurus
    EXPORT PhonetisaurusTargets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
    INCLUDES DESTINATION include
)

install(FILES ${HEADER} DESTINATION include)

install(DIRECTORY include/
        DESTINATION include/)
        
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    PhonetisaurusConfigVersion.cmake
    VERSION ${PACKAGE_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(EXPORT PhonetisaurusTargets
        FILE PhonetisaurusTargets.cmake
        NAMESPACE Phonetisaurus::
        DESTINATION lib/cmake/Phonetisaurus
)

#configure_file(PhonetisaurusConfig.cmake.in PhonetisaurusConfig.cmake @ONLY)