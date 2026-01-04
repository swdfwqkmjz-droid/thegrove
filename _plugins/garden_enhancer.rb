# _plugins/grove_enhancer.rb

# Enhances Jekyll grove with:
# 1. Bidirectional linking
# 2. [[Wiki-style link]] resolution
# 3. Backlink generation
# 4. Status-based CSS class support

module Jekyll
  class GardenLinkProcessor < Generator
    safe true
    priority :low

    def generate(site)
      # Support custom collection name like 'grove_items'
      grove_collection = site.collections['grove_items']
      return unless grove_collection

      notes = grove_collection.docs
      note_map = {}
      backlinks = Hash.new { |h, k| h[k] = [] }

      notes.each do |note|
        title = note.data['title']
        slug = note.url.gsub(%r{^/|/$}, '')
        note.data['slug'] = slug
        note_map[title] = note
      end

      notes.each do |note|
        content = note.content

        content.gsub!(/\[\[([^\]]+)\]\]/) do
          target_title = $1.strip
          if note_map.key?(target_title)
            target = note_map[target_title]
            backlinks[target.url] << { "url" => note.url, "title" => note.data["title"] }
            "[#{target_title}](/#{target.data['slug']})"
          else
            "<span class='broken-link'>[[#{target_title}]]</span>"
          end
        end

        note.content = content
      end

      notes.each do |note|
        note.data["backlinks"] = backlinks[note.url] if backlinks.key?(note.url)
      end
    end
  end
end