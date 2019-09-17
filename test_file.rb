# frozen_string_literal: true

require 'benchmark'
require_relative 'fib_fac'

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
