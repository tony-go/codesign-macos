cmake_minimum_required(VERSION 3.2)
project(MyMacOSApp LANGUAGES CXX)

set(APP_NAME MyMacOSApp)
set(CMAKE_MACOSX_BUNDLE YES)

add_executable(${APP_NAME} main.m)

# This line ensure that .app will be bundled in the dmg
install(TARGETS ${APP_NAME} BUNDLE DESTINATION ".")

target_link_libraries(${APP_NAME} "-framework Cocoa")

set(CPACK_PACKAGE_NAME ${APP_NAME})
include(CPack)
