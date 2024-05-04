init:
    cmake -B build -GNinja

build: init
    cmake --build build

install: build
    rm -rf install
    mkdir -p install
    cmake --install build  --prefix install

clean:
    rm -rf build install