# Cross Compiler

```bash
PREFIX="usr/opt/cross"
TARGET=i686-elf
PATH="$PREFIX/bin:$PATH"
```

```bash
git clone git://gcc.gnu.org/git/gcc.git build-gcc
git clone git://sourceware.org/git/binutils-gdb.git binutils-gdb
```

```bash
../binutils-gdb/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install
```

```bash
