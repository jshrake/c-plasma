init:
    cmake -B build/desktop -GNinja

build: init
    cmake --build build/desktop --config Release

install: build
    cmake --install build/desktop  --prefix build/install/desktop

clean:
    rm -rf build

desktop: install

macos:
    cmake -B build/macos -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=MAC_UNIVERSAL -DBUILD_BINS=OFF
    cmake --build build/macos --config Release
    cmake --install build/macos  --prefix build/install/macos

ios:
    cmake -B build/ios -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=OS64 -DBUILD_BINS=OFF
    cmake --build build/ios --config Release
    cmake --install build/ios  --prefix build/install/ios

ios-sim:
    cmake -B build/ios-sim -G Xcode -DCMAKE_TOOLCHAIN_FILE=cmake/ios-cmake/ios.toolchain.cmake -DPLATFORM=SIMULATORARM64 -DBUILD_BINS=OFF
    cmake --build build/ios-sim --config Release
    cmake --install build/ios-sim --prefix build/install/ios-sim

xcframework: macos ios ios-sim
    rm -rf build/install/xcframework
    mkdir -p build/install/xcframework
    xcodebuild -create-xcframework \
        -framework build/install/macos/Library/Frameworks/plasma.framework \
        -framework build/install/ios/Library/Frameworks/plasma.framework \
        -framework build/install/ios-sim/Library/Frameworks/plasma.framework \
        -output build/install/xcframework/plasma.xcframework
