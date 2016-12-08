project(concurrency)
cmake_minimum_required(VERSION 3.0)

option(BUILD_SHARED_LIBS "Specify to build shared or static library." Off)

include(conanbuildinfo.cmake)
conan_basic_setup()

set(CMAKE_CXX_STANDARD 14)
add_definitions(-Werror=all)

add_subdirectory(concurrency)

enable_testing()
add_subdirectory(test)

file(WRITE ${CMAKE_BINARY_DIR}/concurrency-config.cmake
  "include(\"\${CMAKE_CURRENT_LIST_DIR}/concurrency.cmake\")"
)
install(FILES ${CMAKE_BINARY_DIR}/concurrency-config.cmake
  DESTINATION lib/cmake/concurrency
  COMPONENT Devel
)
install(EXPORT concurrency NAMESPACE concurrency:: DESTINATION lib/cmake/concurrency)