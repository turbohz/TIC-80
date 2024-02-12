default: clean update build

clean:
    git clean -xfd && cd build && make clean || true

update:
    # https://github.com/nesbox/TIC-80?tab=readme-ov-file#arch
    sudo pacman -S --needed cmake ruby mesa libglvnd glu
    git submodule update --init --recursive vendor/argparse
    git submodule update --init --recursive vendor/sdl2
    git submodule update --init --recursive vendor/libpng
    git submodule update --init --recursive vendor/zip
    git submodule update --init --recursive vendor/naett
    git submodule update --init --recursive vendor/giflib
    git submodule update --init --recursive vendor/msf_gif
    git submodule update --init --recursive vendor/blip-buf
    git submodule update --init --recursive vendor/zlib
    git submodule update --init --recursive vendor/wasm3
    git submodule update --init --recursive vendor/dlfcn
    git submodule update --init --recursive vendor/jsmn
    git submodule update --init --recursive vendor/sdl-gpu

build:
    # https://github.com/nesbox/TIC-80?tab=readme-ov-file#arch
    cd build && cmake .. \
    -DBUILD_WITH_LUA=OFF \
    -DBUILD_WITH_MOON=OFF \
    -DBUILD_WITH_FENNEL=OFF \
    -DBUILD_WITH_JS=OFF \
    -DBUILD_WITH_SCHEME=OFF \
    -DBUILD_WITH_SQUIRREL=OFF \
    -DBUILD_WITH_PYTHON=OFF \
    -DBUILD_WITH_WREN=OFF \
    -DBUILD_WITH_RUBY=OFF \
    -DBUILD_WITH_JANET=OFF \
    -DBUILD_WITH_WASM=ON \
    -DBUILD_DEPRECATED=OFF \
    -DBUILD_LIBRETRO=OFF \
    -DBUILD_SDL=ON \
    -DBUILD_PRO=ON \
    -DBUILD_STATIC=ON \
    -DBUILD_PLAYER=ON \
    -DBUILD_DEMO_CARTS=OFF \
    -DBUILD_TOUCH_INPUT=OFF \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    cd build && cmake --build . --parallel
    cd build && make && sudo make install
