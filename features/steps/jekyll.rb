When /^I create a blog post$/ do
  in_project_folder do
    File.open("website/_posts/2008-12-21-my-first-post.markdown", "w") do |f|
      f << <<-EOS.gsub(/^      /, '')
      ---
      layout: post
      title: My first post
      ---
      
      This is my post
      EOS
    end
  end
end

Then /^blog post HTML file is created$/ do
  in_project_folder do
    File.should be_exist("website/_site/2008/12/21/my-first-post.html")
  end
end
