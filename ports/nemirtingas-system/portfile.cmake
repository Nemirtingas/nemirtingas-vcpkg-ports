set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/System
    REF "v${VERSION}"
    SHA512 d273c4b49677edd1980e9eca2fbf82b609beef26fd445cea1934d32cdf051454af8c44e33c2747fa54cc4ecbacac1ea518b7bdfd36c793cde0c47208e5dc0568
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_SYSTEMLIB_TESTS=OFF
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_cmake_config_fixup(PACKAGE_NAME System CONFIG_PATH lib/cmake/System)
vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)