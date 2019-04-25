require "image_optim"
require 'yaml'

module Jekyll

  class ImageOptimGenerator < Generator
    safe true

    ###########################################################################
    # Entry point for the plugin.
    def generate(site)
      # Read configuration. Defaults first, then overrides from _config.yml.
      config = YAML::load_file "_config.yml"
      config = config["image_optim"] || {}
      @config = default_options.merge! config

      # Initialize the ImageOptim library, which does the heavy lifting.
      @image_optim = ImageOptim.new(
        {
          :allow_lossy => true,  #Allow worker, it is always lossy (defaults to false)
          :svgo => false,
          :pngout => false,
          :verbose => false,
          :pngquant => {:quality => 70..85},  #min..max - don't save below min, use less colors below max (both in range 0..100; in yaml - !ruby/range 0..100), ignored in default/lossless mode (defaults to 100..100, 0..100 in lossy mode)
          :jpegrecompress => {:quality => 0},   #JPEG quality preset: 0 - low, 1 - medium, 2 - high, 3 - veryhigh (defaults to 3)
          :jpegoptim => {:max_quality => 85}
        })

      # Read the cache file, if it exists.
      @last_update = YAML::load_file @config["cache_file"] if File.file? @config["cache_file"]
      @last_update ||= {}

      # Create the originals directory.
      FileUtils.mkdir_p @config["archive_dir"]

      # Iterate over all images, optimizing as necessary.
      Dir.glob(@config["image_glob"]) { |image| analyze image }

      # Save modifications back to the cache file.
      File.open(@config["cache_file"], "w") { |file| file.write @last_update.to_yaml }
    end

    ###########################################################################
    # Native settings for the plugin.
    # Override with corresonding entries to _config.yml under "image_optim"
    #
    # Example:
    #
    #   [_config.yml]
    #   image_optim:
    #     archive_dir: "_my_original_images"
    #     cache_file: "_custom_file.yml"
    #     image_glob: "webroot/images/*.png"
    def default_options
      {
        # Where do we store archival copies of the originals?
        "archive_dir" => "_image_optim_archive",
        # Where do we store our cache file?
        "cache_file" => "_image_optim_cache.yml",
        # What images do we search for?
        "image_glob" => "images/**/*.{gif,jpg,jpeg,png}",
      }
    end

    ###########################################################################
    # Determine whether or not optimization needs to occur.
    def analyze(image)
      if @last_update.has_key? image
        # If we've touched the image before, but it's been modified, optimize.
        optimize image if @last_update[image] != File.mtime(image)
      else
        # If the image is new, optimize.
        optimize image
      end
    end

    ###########################################################################
    # In-place image optimization per the ImageOptim library.
    def optimize(image)
      puts "Optimizing #{image}"
      FileUtils.copy image, archival_filename(image)
      @image_optim.optimize_image! image
      @last_update[image] = File.mtime image
    end

    ###########################################################################
    # Adds the date/time of archival as well as the MD5 digest of the original
    # source file.
    def archival_filename(image)
      ext = File.extname(image)
      "%s/%s-%s-%s%s" % [
        @config["archive_dir"],
        File.basename(image, ext),
        DateTime.now.strftime("%Y-%m-%d-%H-%M-%S"),
        Digest::MD5.file(image).hexdigest,
        ext,
      ]
    end

  end
end
