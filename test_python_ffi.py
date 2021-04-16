import unittest

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


class TestPythonFFI(unittest.TestCase):
    def test_fac(self):
        self.assertEqual(py_fac(8), RUST_FAC(8))

    def test_fac_i(self):
        self.assertEqual(py_fac_i(8), RUST_FAC_I(8))

    def test_fib_i(self):
        self.assertEqual(py_fib_i(8), RUST_FIB_ITER(8))

    def test_fib(self):
        self.assertEqual(py_fib(8), RUST_FIB(8))
