from ctypes import cdll
from sys import platform


def choose_prefix_and_ext():
    if platform == "darwin":
        return ["lib", "dylib"]
    elif platform == "win32":
        return ["", "dll"]
    else:
        return ["lib", "so"]


def load_rust_lib():
    prefix, ext = choose_prefix_and_ext()
    return cdll.LoadLibrary(f"target/release/{prefix}fib.{ext}")


lib = load_rust_lib()
RUST_FIB, RUST_FIB_ITER, RUST_FAC, RUST_FAC_I = (
    lib.fib,
    lib.fib_iter,
    lib.fac,
    lib.fac_i,
)


def py_fac(num):
    if num == 0:
        return 1
    else:
        return num * py_fac(num - 1)


def py_fac_i(num):
    return py_fac_iter(product=1, counter=1, max_counter=num)


def py_fac_iter(product, counter, max_counter):
    if counter > max_counter:
        return product
    return py_fac_iter(product * counter, counter + 1, max_counter)


def py_fib(num):
    if num < 3:
        return 1
    return py_fib(num - 1) + py_fib(num - 2)


def py_fib_i(num):
    return py_fib_iter_engine(1, 0, num)


def py_fib_iter_engine(product, prev_product, counter):
    if counter == 0:
        return prev_product
    return py_fib_iter_engine(product + prev_product, product, counter - 1)
