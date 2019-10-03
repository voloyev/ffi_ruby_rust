# frozen_string_literal: true

require 'benchmark'
require_relative 'ruby_ffi'

Benchmark.bm(10) do |x|
  number = ARGV[0] || 15
  number = number.to_i

  puts 'embbed rust'
  puts 'fib'
  x.report { puts WithRust.fib(number) }

  puts 'fib_iter'
  x.report { puts WithRust.fib_iter(number) }

  puts 'fac'
  x.report { puts WithRust.fac(number) }
  puts "\n"

  puts 'fac_i'
  x.report { puts WithRust.fac_i(number) }
  puts "\n"

  puts 'just ruby'
  puts 'fib'
  x.report { puts JustRuby.fib(number) }
  puts 'fib_iter'
  x.report { puts JustRuby.fib_iter(number) }

  puts 'fac'
  x.report { puts JustRuby.fac(number) }
  puts "\n"
  puts 'fac_i'
  x.report { puts JustRuby.fac_i(number) }
  puts "\n"
end
