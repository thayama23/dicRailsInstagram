class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def show
  end

  def new
    # @blog = current_user.blogs.build
    # @blog = Blog.new

    # if params[:back]
    #   @feed = Feed.new(feed_params)
    # else
    #   @feed = Feed.new
    # end
    if current_user == nil
      redirect_to new_user_path, notice: "ログインするか新規ユーザー設定後Blogをご使用下さい。"
    else
      @blog = current_user.blogs.build
    end

  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id #現在ログインしているuserのidを、blogのuser_idカラムに挿入する
  end

  private
  def blog_params
   params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

end
