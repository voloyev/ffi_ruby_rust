# frozen_string_literal: true

require 'ffi'
require 'benchmark'

# fibonacci in with rust
module WithRust
  extend FFI::Library
  ffi_lib 'target/release/libfib.dylib'
  attach_function :fib, [:int], :int
end

# fibonacci in pure ruby
module JustRuby
  def self.fib(num)
    num < 3 ? 1 : fib(num - 1) + fib(num - 2)
  end
end

Benchmark.bm(10) do |x|
  number = 50
  puts 'just ruby'
  x.report { JustRuby.fib(number) }
  puts "\n"

  puts 'embbed rust'
  x.report { WithRust.fib(number) }
  puts "\n"
end
