module PostsHelper
  def title_text(post)
    if post.url.nil?
      post.title
    else
      (link_to h(post.title), h(post.url)).html_safe
    end
  end
end
