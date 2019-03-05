#[no_mangle]
pub extern "C" fn fib(n: u64) -> u64 {
    if n < 3 {
        return 1;
    } else {
        return fib(n - 1) + fib(n - 2);
    }
}

#[no_mangle]
pub extern "C" fn fib_iter(n: u64) -> u64 {
    fib_iter_engine(1, 0, n)
}

fn fib_iter_engine(a: u64, b: u64, counter: u64) -> u64 {
    if counter == 0 {
        return b;
    }

    fib_iter_engine(a + b, a, counter - 1)
}

#[no_mangle]
pub extern "C" fn fac(n: u64) -> u64 {
    if n < 1 {
        return 1;
    } else {
        return n * fac(n - 1);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn fib_test() {
        let fib_num = fib(6);
        assert_eq!(fib_num, 8);
    }

    #[test]
    fn fib_iter_test() {
        let fib_i = fib_iter(6);
        assert_eq!(fib_i, 8);
    }

    #[test]
    fn fib_impl_eq() {
        assert_eq!(fib(7), fib_iter(7));
    }

    #[test]
    fn fac_test() {
        let fac_num = fac(5);
        assert_eq!(fac_num, 120);
    }
}
