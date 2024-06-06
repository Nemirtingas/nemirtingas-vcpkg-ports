set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/ingame_overlay
    REF "v${VERSION}"
    SHA512 ad288e625281e766ce6dff5f1381a67b219c372569498dad0d01483fce6f89449a13bfd46d6ef91b706f4de246548329a9f0b057010955d8ab842b1028a0aa74
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