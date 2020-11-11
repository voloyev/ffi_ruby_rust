from ctypes import cdll
from sys import platform


def choose_prefix_and_ext():
    if platform == 'darwin':
        return ['lib', 'dylib']
    elif platform == 'win32':
        return ['', 'dll']
    else:
        return ['lib', 'so']


def load_rust_lib():
    prefix, ext = choose_prefix_and_ext()
    return cdll.LoadLibrary('target/debug/{}fib.{}'.format(prefix, ext))


def py_fac(num):
    if num == 0:
        return 1
    else:
        return num * py_fac(num-1)


lib = load_rust_lib()

rust_fib, rust_fac = lib.fib, lib.fac


def test_implementations():
    python = py_fac(40)
    rust = rust_fac(40)
    assert rust == python
