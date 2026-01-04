module Jekyll
  class MusicTagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'music-tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Music tagged “#{tag}”"
    end
  end

  class MusicTagGenerator < Generator
    safe true

    def generate(site)
      if site.collections['music']
        tags = site.collections['music'].docs.flat_map { |doc| doc.data['tags'] || [] }.uniq
        tags.each do |tag|
          site.pages << MusicTagPage.new(site, site.source, File.join('music', 'tags', tag.downcase.gsub(' ', '-')), tag)
        end
      end
    end
  end
end
