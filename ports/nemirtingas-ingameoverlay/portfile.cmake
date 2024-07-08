set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/ingame_overlay
    REF "v${VERSION}"
    SHA512 b3196dab6d00f2d57bea2a8f025258f0a216d9fef9a9b3c9b035cdb8533d33724f84a8f208436eaf593372ce9d67b5f10679f377cac1ec42d27906f6723fbf6c
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH IMGUI_SOURCE_PATH
    REPO Nemirtingas/ImGui
    REF my_master
    SHA512 c4f98110808728af9b2f06c5de713e590cdac6ab526b224e8365c61519032c19339262643ff2c728b532bd5d681033fb26beb82e2f672edfb84d95807261749b
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