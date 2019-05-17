# frozen_string_literal: true

require 'ffi'
require 'benchmark'

# fibonacci in with rust
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
  end
end

Benchmark.bm(10) do |x|
  number = ARGV[0] || 20
  number = number.to_i

  puts 'embbed rust'
  puts 'fib'
  x.report { WithRust.fib(number) }

  puts 'fib_iter'
  x.report { WithRust.fib_iter(number) }

  puts 'fac'
  x.report { WithRust.fac(number) }
  puts "\n"

  puts 'fac_i'
  x.report { WithRust.fac_i(number) }
  puts "\n"

  puts 'just ruby'
  puts 'fib'
  x.report { JustRuby.fib(number) }
  puts 'fib_iter'
  x.report { JustRuby.fib_iter(number) }

  puts 'fac'
  x.report { JustRuby.fac(number) }
  puts "\n"
  puts 'fac_i'
  x.report { JustRuby.fac_i(number) }
  puts "\n"
end
