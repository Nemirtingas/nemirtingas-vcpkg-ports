set(VCPKG_LIBRARY_LINKAGE "static")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nemirtingas/Socket
    REF "v${VERSION}"
    SHA512 c85438e8876b1c996520efdca509f0b0aad1607b7f38d1e785a6eab739feb728adfcb2b3c8f5550a5421dbcf53b65c0285056a12325a7cd39d61bf3e4280ba41
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_cmake_config_fixup(PACKAGE_NAME NetworkLibrary CONFIG_PATH lib/cmake/NetworkLibrary)
vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)