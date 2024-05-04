init:
    cmake -B build -GNinja

build: init
    cmake --build build --config Release

install: build
    rm -rf install
    mkdir -p install
    cmake --install build  --prefix install

clean:
    rm -rf build install build-ios install-ios

ios:
    rm -rf build-ios install-ios
    cmake -B build-ios -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=OS64 -DBUILD_BINS=OFF
    cmake --build build-ios --config Release
    cmake --install build-ios  --prefix install-ios