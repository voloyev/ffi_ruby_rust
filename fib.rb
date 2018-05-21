# frozen_string_literal: true

require 'ffi'
require 'benchmark'

# fibonacci in with rust
module WithRust
  extend FFI::Library
  ffi_lib 'target/release/libfib.dylib'
  attach_function :fib, [:int], :int
  attach_function :fac, [:int], :int
end

# fibonacci in pure ruby
module JustRuby
  def self.fib(num)
    num < 3 ? 1 : fib(num - 1) + fib(num - 2)
  end

  def self.fac(num)
    num < 1 ? 1 : num * fac(num - 1)
  end
end

Benchmark.bm(10) do |x|
  number = ARGV[0] || 20
  number = number.to_i
  puts 'just ruby'
  puts 'fib'
  x.report { JustRuby.fib(number) }
  puts 'fac'
  x.report { JustRuby.fac(number) }
  puts "\n"

  puts 'embbed rust'
  puts 'fib'
  x.report { WithRust.fib(number) }
  puts 'fac'
  x.report { WithRust.fac(number) }
  puts "\n"
end
