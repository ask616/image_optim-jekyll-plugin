[![Gem Version](https://badge.fury.io/rb/jekyll-image-optim.svg)](https://badge.fury.io/rb/jekyll-image-optim)

# jekyll-image-optim
A simple Jekyll plugin gem (forked from [chrisanthropic/image_optim-jekyll-plugin]) to optimize images using [image_optim].

---
### Usage
Runs automatically when you `jekyll build`:

```bash
# Add a new image to the site.
cp ~/downloads/cheese-cat-fail.jpg ~/website/images/

# Build the site; image_optim-jekyll-plugin runs automatically.
~/website:master > bundle exec jekyll build
Configuration file: /home/chris/website/_config.yml
            Source: /home/chris/website
       Destination: /home/chris/website/_site
      Generating...
Optimizing images/cheese-cat-fail.jpg
                    done.
 Auto-regeneration: disabled. Use --watch to enable.
```

Let's look at what changed:

```bash
~/website:master > git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   _image_optim_cache.yml

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	_image_optim_archive/cheese-cat-fail-2016-10-14-09-10-15-02de96ea1978a39c4b7860e8d1125773.jpg
	images/cheese-cat-fail.jpg

no changes added to commit (use "git add" and/or "git commit -a")
```

You see three changes:

  1. New file: `images/cheese-cat-fail.jpg`, which I added manually to my image root (`assets/img`). This image is automatically optimized in-place by the plugin. _Repeat: **this is not the original file**, as optimization is done in-place._
  2. New file: `_image_optim_archive/cheese-cat-fail-2016-10-14-09-10-15-02de96ea1978a39c4b7860e8d1125773.jpg`. This is a copy of the original file (before optimization). It's tagged with the date/time of optimization as well as the MD5 of the original content.
  3. Changed file: `_image_optim_cache.yml` is for internal use by the plugin (it keeps track of which images have been optimized, and when).

---
### Installation
To install as a gem, add this line to your Jekyll site's `Gemfile` under the `:jekyll_plugins` group:

```ruby
gem "jekyll-image-optim"
```

Then add this line to your Jekyll site's `_config.yml` under `plugins`:

```yaml
plugins:
  - jekyll-image-optim
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-image-optim

---
### Configuration
_**Note**: All paths are relative to the site root._

**`archive_dir`**: Directory in which copies of original images are saved for future reference.
  * Type: `string`
  * Default: `"_image_optim_archive"`

**`cache_file`**: Path to a file where the plugin keeps its internal metadata.
  * Type: `string`
  * Default: `"_image_optim_cache.yml"`

**`image_glob`**: Path that specifies which images are to be optimized.
  * Type: `string`
  * Default: `"images/**/*.{gif,jpg,jpeg,png}"`

You can override configuration defaults by keying them under `image_optim` in `_config.yml`. Here's an example:

###### config.yml:
```yaml
# Site stuff.
title: My Cat Blog
baseurl: "/cats"
permalink: "/:year/:title.html"

# Deployment exclusions.
exclude:
  - .gitignore
  - Gemfile
  - Gemfile.lock

# image_optim-jekyll-plugin customizations.
image_optim:
  archive_dir: "assets/full-res-kittens"
  cache_file: "tmp/kitty-cache.yml"
  image_glob: "assets/img/**/cat-*.{gif,png,jpg,jpeg}"
```

_**Note**: Your use case will dictate whether you choose to include or exclude your `archive_dir` and/or `cache_file` in source control._

---
### License
[MIT](LICENSE.txt)

[chrisanthropic/image_optim-jekyll-plugin]: https://github.com/chrisanthropic/image_optim-jekyll-plugin
[image_optim]: https://github.com/toy/image_optim
