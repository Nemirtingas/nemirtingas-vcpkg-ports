set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/gamepad
    REF "v${VERSION}"
    SHA512 3aaa77c9244c286138e8e1b1ab0639a68f2c5b8ba7ff3a47851582956198776ed4494325f57f291930447ffa13d61b80ac3103471805692e83184a35ea6d7f5c
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DGAMEPAD_BUILD_EXAMPLE=OFF
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_cmake_config_fixup(PACKAGE_NAME Gamepad CONFIG_PATH lib/cmake/Gamepad)
vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)