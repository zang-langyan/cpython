export LLVM_HOME="/opt/homebrew/opt/llvm"
export CC=$LLVM_HOME/bin/clang
export CXX=$LLVM_HOME/bin/clang++
export LDFLAGS="-L/Users/langyan/dev/ccviztracer/build/"
export LIBS="-lcctracer -lc++"
export CFLAGS="-fpass-plugin=/Users/langyan/dev/ccviztracer/build/cctracer_pass.dylib"
export CCTRACER_ENABLE=0

cd debug
make clean
echo "Rebuilding with debug symbols and custom CFLAGS"

make -j16
