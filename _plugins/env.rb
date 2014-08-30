module Jekyll
 
  class EnvironmentVariablesGenerator < Generator
 
    def generate(site)
      site.config['env'] = ENV['JEKYLL_ENV'] || 'production'
      site.config['skip_disqus'] = ENV['JEKYLL_SKIP_DISQUS'] || false
      site.config['skip_social'] = ENV['JEKYLL_SKIP_SOCIAL'] || false
    end
 
  end
 
end