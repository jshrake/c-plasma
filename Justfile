init:
    cmake -B build -GNinja

build: init
    cmake --build build --config Release

install: build
    rm -rf install
    mkdir -p install
    cmake --install build  --prefix install

clean:
    rm -rf build install

desktop: clean init build install

ios: clean
    cmake -B build -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=OS64 -DBUILD_BINS=OFF
    cmake --build build --config Release
    cmake --install build  --prefix install