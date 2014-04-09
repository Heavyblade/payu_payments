# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payu_payments/version'

Gem::Specification.new do |spec|
  spec.name          = "payu_payments"
  spec.version       = PayuPayments::VERSION
  spec.authors       = ["CristianV"]
  spec.email         = ["cristian@kommit.co"]
  spec.summary       = %q{Payulatam payments gatewat API gem}
  spec.description   = %q{Payulatam payments gatewat API gem}
  spec.homepage      = "https://github.com/Heavyblade/payu_payments"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Dependency
  spec.add_dependency "httparty"

  # Development
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
end
