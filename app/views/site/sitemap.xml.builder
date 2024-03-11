xml.instruct!
xml.urlset "xmlns" => "https://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc request.base_url + "/contact"
    xml.lastmod Date.today
    xml.changefreq 'monthly'
    xml.priority 0.9
  end
  @pages.each do |page|
    parents_with_partial = page.path.split('/').map do |part|
    	part =~ /^_/
    end
    next if parents_with_partial.any?
    xml.url do
      xml.loc request.base_url + page.path
      xml.lastmod page.updated_at.to_date
      xml.changefreq 'monthly'
      xml.priority 0.9
    end
  end
end