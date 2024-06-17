init:
    cmake -B build -GNinja

build: init
    cmake --build build --config Release

install: build
    cmake --install build --prefix build/install

clean:
    rm -rf build

xcframework: macos ios ios-sim
    rm -rf build/install/xcframework
    mkdir -p build/install/xcframework
    xcodebuild -create-xcframework \
        -library build/install/macos/lib/libplasma.a -headers build/install/macos/include \
        -library build/install/ios/lib/libplasma.a -headers build/install/ios/include \
        -library build/install/ios-sim/lib/libplasma.a -headers build/install/ios-sim/include \
        -output build/install/xcframework/plasma.xcframework

macos:
    cmake -B build/macos -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=MAC_UNIVERSAL -DBUILD_BINS=OFF -DYAML_SUPPORT=ON
    cmake --build build/macos --config Release
    cmake --install build/macos  --prefix build/install/macos

ios:
    cmake -B build/ios -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=OS64 -DBUILD_BINS=OFF -DYAML_SUPPORT=OFF
    cmake --build build/ios --config Release
    cmake --install build/ios  --prefix build/install/ios

ios-sim:
    cmake -B build/ios-sim -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=SIMULATORARM64 -DBUILD_BINS=OFF -DYAML_SUPPORT=OFF
    cmake --build build/ios-sim --config Release
    cmake --install build/ios-sim --prefix build/install/ios-sim
