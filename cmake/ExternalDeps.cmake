include(ExternalProject)

set(EXTERNAL_INSTALL_LOCATION ${CMAKE_BINARY_DIR}/external)

ExternalProject_Add(openfst
    GIT_REPOSITORY https://github.com/kkm000/openfst
    GIT_TAG winport
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_LOCATION}
)

ExternalProject_Add(librnnlm
    GIT_REPOSITORY https://github.com/as-shura/rnnlm
    GIT_TAG main
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_LOCATION}
)

include_directories(${EXTERNAL_INSTALL_LOCATION}/include)

add_dependencies(Phonetisaurus openfst librnnlm)