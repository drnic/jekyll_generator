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
  file = "website/_site/2008/12/21/my-first-post.html"
  in_project_folder do
    File.should be_exist(file)
  end
  Given "contents of file '#{file}' does match /<head>/"
  Given "contents of file '#{file}' does match /<title>My first post</title>/"
  Given "contents of file '#{file}' does match /This is my post/"
end
