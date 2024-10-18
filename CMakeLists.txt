cmake_minimum_required(VERSION 3.2)
project(MyMacOSApp LANGUAGES CXX)

set(TEAM_ID "" CACHE STRING "The development team ID for code signing")

if(TEAM_ID STREQUAL "")
    message(FATAL_ERROR "Please set the TEAM_ID variable when generating the project")
endif()


set(APP_NAME MyMacOSApp)
set(CMAKE_MACOSX_BUNDLE YES)

set(XCODE_ATTRIBUTE_CODE_SIGN_STYLE "Manual")
set(XCODE_ATTRIBUTE_DEVELOPMENT_TEAM ${TEAM_ID})
set(XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Developer ID Application")
set(XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED TRUE)

add_executable(${APP_NAME} main.m)

set_target_properties(${APP_NAME} PROPERTIES
    XCODE_ATTRIBUTE_CODE_SIGN_STYLE ${XCODE_ATTRIBUTE_CODE_SIGN_STYLE}
    XCODE_ATTRIBUTE_DEVELOPMENT_TEAM ${XCODE_ATTRIBUTE_DEVELOPMENT_TEAM}
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY ${XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY}
    XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED ${XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED}
    XCODE_ATTRIBUTE_OTHER_CODE_SIGN_FLAGS "--timestamp=http://timestamp.apple.com/ts01  --options=runtime,library"
    XCODE_ATTRIBUTE_CODE_SIGN_INJECT_BASE_ENTITLEMENTS "NO"
)

# This line ensures that .app will be bundled in the dmg
install(TARGETS ${APP_NAME} BUNDLE DESTINATION ".")

target_link_libraries(${APP_NAME} "-framework Cocoa")

set(CPACK_PACKAGE_NAME ${APP_NAME})
include(CPack)
