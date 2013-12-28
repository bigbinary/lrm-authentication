class Api::V1::PostsController < ApplicationController

  def index
    posts = Posts.all.to_a.map do |post|
              {title: post.title, content: post.content}
            end
    render json: {posts: posts }, response: :success
  end

end
