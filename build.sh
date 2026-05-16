export LLVM_HOME="/opt/homebrew/opt/llvm"
export CC=$LLVM_HOME/bin/clang
export CXX=$LLVM_HOME/bin/clang++
echo "Using CC: $CC"
echo "Using CXX: $CXX"

# Add static library paths and libraries
export LDFLAGS="-L/Users/langyan/dev/ccviztracer/build/ -L/Users/langyan/dev/ccviztracer/build/extern/perfetto_sdk/"
export LIBS="-lcctracer -lperfetto -lc++" 

# Don't set CFLAGS here - let configure set them first

rm -rf debug
mkdir debug
cd debug

echo "Configuring Python build with debug symbols"
../configure --with-pydebug --with-llvm --with-llvm-config=$LLVM_HOME/bin/llvm-config $CONFIG_ARGS

echo "Modifying Makefile to add custom CFLAGS"
# Add your custom flags to the existing CFLAGS in Makefile
# CONFIGURE_CFLAGS=	-fpass-plugin=/Users/langyan/dev/ccviztracer/build/cctracer_pass.dylib -I/Users/langyan/dev/ccviztracer/extern/perfetto_sdk
export CFLAGS="-fpass-plugin=/Users/langyan/dev/ccviztracer/build/cctracer_pass.dylib -I/Users/langyan/dev/ccviztracer/extern/perfetto_sdk"

make -j16
# make test