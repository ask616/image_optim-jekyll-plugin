# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-image-optim"
  spec.version       = "1.0.6"
  spec.authors       = ["Areeb Khan"]
  spec.email         = ["areebk@protonmail.com"]

  spec.summary       = "A simple Jekyll plugin to optimize images using image_optim"
  spec.description   = "A simple Jekyll plugin to optimize images using image_optim. Configuration and usage instructions can be found at https://github.com/ask616/jekyll-image-optim"
  spec.homepage      = "https://github.com/ask616/jekyll-image-optim"
  spec.license       = "MIT"

  spec.files         = ["lib/jekyll-image-optim.rb"]

  spec.add_runtime_dependency "image_optim", "~> 0.26"
  spec.add_runtime_dependency "image_optim_pack", "~> 0.5"
end
