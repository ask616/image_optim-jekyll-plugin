# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-image-optim"
  spec.version       = "1.0.2"
  spec.authors       = ["Areeb Khan"]
  spec.email         = ["areebk@protonmail.com"]

  spec.summary       = "A simple Jekyll plugin to optimize images using image_optim"
  spec.description   = "Plugin to compress images. Configuration and usage instructions can be found at https://github.com/chrisanthropic/image_optim-jekyll-plugin"
  spec.homepage      = "https://github.com/chrisanthropic/image_optim-jekyll-plugin"
  spec.license       = "MIT"

  spec.files         = ["lib/image_optim.rb"]

  spec.add_runtime_dependency "image_optim"
  spec.add_runtime_dependency "image_optim_pack"
end
