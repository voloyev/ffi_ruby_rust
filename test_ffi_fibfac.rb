require 'test/unit'
require_relative 'fib_fac'

class TestFibImplementation < Test::Unit::TestCase
  def test_fib_equality_between_iter_and_recur_impl_in_ruby
    assert_equal(JustRuby.fib(15), JustRuby.fib_iter(15))
  end

  def test_fib_rec_impl
    assert_equal(JustRuby.fib(15), WithRust.fib(15))
  end

  def test_fib_iter_impl
    assert_equal(JustRuby.fib_iter(20), WithRust.fib_iter(20))
  end

  def test_fac_equality_between_iter_and_recur_impl_in_ruby
    assert_equal(JustRuby.fac(20), JustRuby.fac_i(20))
  end

  def test_fac_recur_impl
    assert_equal(JustRuby.fac(30), WithRust.fac(30))
  end

  def test_fac_iter_impl
    assert_equal(JustRuby.fac_i(30), WithRust.fac_i(30))
  end
end
