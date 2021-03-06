require 'ffi'

# Module to get functions from rust.
module WithRust
  extend FFI::Library
  so_extension = case RUBY_PLATFORM
                 when /darwin/
                   'dylib'
                 when /cygwin|mswin|mingw|bccwin|wince|emx/
                   'dll'
                 else
                   'so'
                 end

  ffi_lib "target/release/libfib.#{so_extension}"
  attach_function :fib, [:uint64], :uint64
  attach_function :fib_iter, [:uint64], :uint64
  attach_function :fac, [:uint64], :uint64
  attach_function :fac_i, [:uint64], :uint64
end

# fibonacci in pure ruby
module JustRuby
  class << self
    def fib(num)
      num < 3 ? 1 : fib(num - 1) + fib(num - 2)
    end

    def fib_iter(n)
      fib_iter_engine(1, 0, n)
    end

    def fib_iter_engine(a, b, counter)
      return b if counter.zero?

      fib_iter_engine(a + b, a, counter - 1)
    end

    def fac(num)
      num < 1 ? 1 : num * fac(num - 1)
    end

    def fac_i(num)
      fac_iter(1, 1, num)
    end

    def fac_iter(product, counter, max_counter)
      return product if counter > max_counter

      fac_iter(product * counter, counter + 1, max_counter)
    end

    def fac_reduce(num)
      (1..num).reduce(&:*)
    end
  end
end
