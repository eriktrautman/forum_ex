class PostsController < ApplicationController
  before_filter :require_signed_in, :unless => Proc.new { |c|
                                      c.request.format == 'application/json' }
  # skip_before_filter :verify_authenticity_token, :require_signed_in, :if =>
  #                     Proc.new { |c| c.request.format == 'application/json' }
  # skip_before_filter :require_signed_in, :if =>
  #                     Proc.new { |c| c.request.format == 'application/json' }
  before_filter :require_api_key, :if =>
                      Proc.new { |c| c.request.format == 'application/json' }


  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      add_api_key
      flash[:success] = "New Post created!"
      redirect_to @post
    else
      flash[:error] = "Post not created!"
      render :new
    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @author = User.find(@post.author_id)
    @comment = Comment.new(post_id: params[:id])
    respond_to do |format|
      format.html { render:show }
      format.json { render:json => @post }
    end
  end

end
