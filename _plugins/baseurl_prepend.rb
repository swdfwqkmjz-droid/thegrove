Jekyll::Hooks.register :pages, :post_render do |page|
  if page.output_ext == ".html"
    baseurl = page.site.config['baseurl'] || ''
    next if baseurl.empty?
    
    # Prepend baseurl to src attributes
    page.output.gsub!(/src=["'](\/[^"']+)["']/, "src=\"#{baseurl}\\1\"")
    
    # Prepend baseurl to href attributes (only internal links starting with /)
    page.output.gsub!(/href=["'](\/[^"']*?)["']/) do |match|
      url = $1
      # Skip external links, anchors, and already-prepended URLs
      if url.start_with?(baseurl) || url.start_with?('http') || url.start_with?('//')
        match
      else
        "href=\"#{baseurl}#{url}\""
      end
    end
  end
end

Jekyll::Hooks.register :posts, :post_render do |post|
  if post.output_ext == ".html"
    baseurl = post.site.config['baseurl'] || ''
    next if baseurl.empty?
    
    post.output.gsub!(/src=["'](\/[^"']+)["']/, "src=\"#{baseurl}\\1\"")
    
    post.output.gsub!(/href=["'](\/[^"']*?)["']/) do |match|
      url = $1
      if url.start_with?(baseurl) || url.start_with?('http') || url.start_with?('//')
        match
      else
        "href=\"#{baseurl}#{url}\""
      end
    end
  end
end

Jekyll::Hooks.register :documents, :post_render do |doc|
  if doc.output_ext == ".html"
    baseurl = doc.site.config['baseurl'] || ''
    next if baseurl.empty?
    
    doc.output.gsub!(/src=["'](\/[^"']+)["']/, "src=\"#{baseurl}\\1\"")
    
    doc.output.gsub!(/href=["'](\/[^"']*?)["']/) do |match|
      url = $1
      if url.start_with?(baseurl) || url.start_with?('http') || url.start_with?('//')
        match
      else
        "href=\"#{baseurl}#{url}\""
      end
    end
  end
end