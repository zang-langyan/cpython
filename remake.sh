export LLVM_HOME="/opt/homebrew/opt/llvm"
export CC=$LLVM_HOME/bin/clang
export CXX=$LLVM_HOME/bin/clang++
export LDFLAGS="-L/Users/langyan/dev/ccviztracer/build/ -L/Users/langyan/dev/ccviztracer/build/extern/perfetto_sdk/"
export LIBS="-lcctracer -lperfetto -lc++" 
export CFLAGS="-fpass-plugin=/Users/langyan/dev/ccviztracer/build/cctracer_pass.dylib -I/Users/langyan/dev/ccviztracer/extern/perfetto_sdk"

cd debug
make clean
echo "Rebuilding with debug symbols and custom CFLAGS"

make -j16