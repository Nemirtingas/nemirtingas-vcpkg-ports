set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/ingame_overlay
    REF "v${VERSION}"
    SHA512 6869ebe30ad71d13aeda1467c78fbc2e552203b8beb7d97817872190a333fbc4e6844e5800bd5a5df8e921979a9ce2fe7ccb62f692edf8baf90508bcc4e2f3dc
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH IMGUI_SOURCE_PATH
    REPO Nemirtingas/ImGui
    REF my_master
    SHA512 682b1fbec4906610c88c46785394ffe19fa22c5378a1830adca5bce2c5bd5a50a658dcd5f72282af1b5a8d1ed777505b4bdd130fe57e41f36bdcb0dde2a8e343
)

file(COPY "${IMGUI_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/deps/ImGui")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DINGAMEOVERLAY_USE_SYSTEM_LIBRARIES=ON
        -DIMGUI_USER_CONFIG="${CMAKE_CURRENT_LIST_DIR}/overlay_imconfig.h"
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_cmake_config_fixup(PACKAGE_NAME InGameOverlay CONFIG_PATH lib/cmake/InGameOverlay)
vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)