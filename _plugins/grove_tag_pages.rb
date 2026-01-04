# _plugins/grove_tag_pages.rb
# This plugin generates a page for each unique tag in the `grove_items` collection.

module Jekyll
  class GroveTagPageGenerator < Generator
    safe true

    def generate(site)
      return unless site.collections['grove_items']

      tags = site.collections['grove_items'].docs.flat_map { |doc| doc.data['tags'] || [] }.uniq

      tags.each do |tag|
        site.pages << TagPage.new(site, site.source, File.join('grove', 'tags', tag.downcase.strip.gsub(' ', '-')), tag)
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Tagged: #{tag}"
      self.data['layout'] = 'tag'
      self.data['permalink'] = "/grove/tags/#{tag.downcase.strip.gsub(' ', '-')}/"
    end
  end
end
