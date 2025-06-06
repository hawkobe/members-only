class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "Post was successfully created"
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.expect(post: [ :title, :body ])
  end
end
