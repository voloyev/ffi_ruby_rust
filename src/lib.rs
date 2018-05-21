#[no_mangle]
pub extern "C" fn fib(n: i32) -> u64 {
    if n < 3 {
        return 1;
    } else {
        return fib(n - 1) + fib(n - 2);
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
