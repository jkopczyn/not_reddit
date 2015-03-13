module PostsHelper
  def title_text(post)
    if post.url.empty?
      post.title
    else
      (link_to h(post.title), h(post.url)).html_safe
    end
  end
end
