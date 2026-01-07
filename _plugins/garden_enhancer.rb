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
        note_map[title.downcase] = note if title
      end

      notes.each do |note|
        content = note.content

        content.gsub!(/\[\[([^\]]+)\]\]/) do
          raw = $1.strip
          target_title = raw
          link_text = nil

          if raw.include?('|')
            parts = raw.split('|', 2)
            target_title = parts[0].strip
            link_text = parts[1].strip
          end

          next "<span class='broken-link'>[[#{raw}]]</span>" if target_title.empty?

          target = note_map[target_title.downcase]
          if target
            backlinks[target.url] << { "url" => note.url, "title" => note.data["title"] }
            display = link_text && !link_text.empty? ? link_text : target_title
            "[#{display}](/#{target.data['slug']})"
          else
            "<span class='broken-link'>[[#{raw}]]</span>"
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
