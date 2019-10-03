mod server_actix;
use actix_web::middleware::Logger;
use actix_web::{web, App, HttpServer};
use env_logger;
use server_actix::{greet, index};

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

#[no_mangle]
pub extern "C" fn fac_i(n: u64) -> u64 {
    fac_iter(1, 1, n)
}

#[no_mangle]
pub extern "C" fn server() {
    std::env::set_var("RUST_LOG", "actix_web=info");
    env_logger::init();
    HttpServer::new(|| {
        App::new()
            .wrap(Logger::default())
            .wrap(Logger::new("%a %{User-Agent}i"))
            .route("/", web::get().to(greet))
            .route("/hello/{name}", web::get().to(greet))
            .route("/index", web::get().to(index))
    })
    .bind("127.0.0.1:8000")
    .expect("Can not bind to port 8000")
    .run()
    .unwrap();
}

fn fac_iter(product: u64, counter: u64, max_counter: u64) -> u64 {
    if counter > max_counter {
        return product;
    }

    fac_iter(product * counter, counter + 1, max_counter)
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

    #[test]
    fn fac_i_test() {
        assert_eq!(fac(6), fac_i(6))
    }
}
