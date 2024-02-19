set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/ingame_overlay
    REF "v${VERSION}"
    SHA512 fab67888115af55c22bc2491c6fc8aaf10fdfe871ac81303e466c7c396b5c42480017e4019b2b732e74d2dae38ccdbb4f6b06a5723542630e384cd1b0ab3898d
    HEAD_REF master
)

vcpkg_from_github(
    OUT_SOURCE_PATH IMGUI_SOURCE_PATH
    REPO Nemirtingas/ImGui
    REF my_master
    SHA512 3bc950b6104dd363ef4fff408b4acb46ed3da65fcfb4ab0c1b6e7b139ae3c96dbf31378d73d5a9ece8c986caa4030f5fbca824d9a03064d14d591d8ea447bc19
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