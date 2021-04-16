import cProfile

from python_ffi import (
    RUST_FAC,
    RUST_FAC_I,
    RUST_FIB,
    RUST_FIB_ITER,
    py_fac,
    py_fac_i,
    py_fib,
    py_fib_i,
)

number = 40
cProfile.run(f"py_fac({number})")
cProfile.run(f"RUST_FAC({number})")

cProfile.run(f"py_fac_i({number})")
cProfile.run(f"RUST_FAC_I({number})")

cProfile.run(f"py_fib({number})")
cProfile.run(f"RUST_FIB({number})")

cProfile.run(f"py_fib_i({number})")
cProfile.run(f"RUST_FIB_ITER({number})")
