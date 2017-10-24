Configure and compile EMBOSS with `-fPIC` then create the shared library for FFI.

We cloned it at https://github.com/pjotrp/emboss

From inside the EMBOSS distribution

    ./configure --without-x --with-pic
    make -j 4
    gcc -shared -o emboss.so  ajax/zlib/*.o ajax/expat/*.o ajax/core/*.o ajax/pcre/*.o

then copy there emboss.so where the FFI script is located.
