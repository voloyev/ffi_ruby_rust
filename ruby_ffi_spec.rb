require 'rspec'
require 'rspec/autorun'
require_relative 'ruby_ffi'

RSpec.describe do
  let(:number) { 20 }
  context 'check equality between ruby implementations of fibonacci' do
    it { expect(JustRuby.fib(number)).to eq(JustRuby.fib_iter(number)) }
  end
  context 'check equality between ruby implementations of factorial' do
    it { expect(JustRuby.fac(number)).to eq(JustRuby.fac_i(number)) }
    it { expect(JustRuby.fac_reduce(number)).to eq(JustRuby.fac_i(number)) }
  end

  context 'check equality between rust and ruby implementations of factorial' do
    it { expect(WithRust.fac(number)).to eq(JustRuby.fac(number)) }
    it { expect(WithRust.fac_i(number)).to eq(JustRuby.fac_i(number)) }
  end

  context 'check equality between rust and ruby implementations of fibonacci' do
    it { expect(WithRust.fib(number)).to eq(JustRuby.fib(number)) }
    it { expect(WithRust.fib_iter(number)).to eq(JustRuby.fib_iter(number)) }
  end
end
