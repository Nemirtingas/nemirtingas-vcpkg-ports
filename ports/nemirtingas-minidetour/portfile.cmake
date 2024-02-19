set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/mini_detour
    REF "v${VERSION}"
    SHA512 16f0cbc53839efc5159d7a7c1ff96579ba53b9c79446cb42291e0c5b788a16937bd1919ede0552b3fb5a07f26733a03993cbc85c334434be9d47457571be77c6
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_MINIDETOUR_TESTS=OFF
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_cmake_config_fixup(PACKAGE_NAME MiniDetour CONFIG_PATH lib/cmake/MiniDetour)
vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)