Configure and compile EMBOSS with `-fPIC` then create the shared library for FFI.
From inside the EMBOSS distribution

    gcc -shared -o emboss.so  ajax/zlib/*.o ajax/expat/*.o ajax/core/*.o ajax/pcre/*.o

then copy there emboss.so where the FFI script is located.
