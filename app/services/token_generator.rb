=begin

require 'benchmark'
require 'securerandom'
require 'random_token'

length = 10
n = 100_000

Benchmark.bm(12) do |x|
  x.report('TokenGenerator') { n.times { Token.generate(length) } }
  x.report('SecureRandom') { n.times { SecureRandom.alphanumeric(length) } }
  x.report('RandomToken') { n.times { RandomToken.gen("%#{length}?") } }
end

                   user     system      total        real
TokenGenerator 0.248203   0.000377   0.248580 (  0.248829)
SecureRandom   0.602512   1.927359   2.529871 (  2.532979)
RandomToken    6.429313   8.378670  14.807983 ( 14.819211)

=end

class TokenGenerator
  CHARS = [(0..9), ('A'..'Z'), ('a'..'z')].map(&:to_a).flatten.freeze

  def self.call(length = 8)
    Array.new(length) { CHARS.sample }.join
  end
end
