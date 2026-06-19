rm -rf debug-jit
mkdir -p debug-jit
cd debug-jit

export LLVM_VERSION=22
export CC=/opt/homebrew/opt/llvm/bin/clang
export CXX=/opt/homebrew/opt/llvm/bin/clang++
echo "Configuring Python build with debug symbols"
../configure --with-pydebug --enable-experimental-jit

make -j16
# make test