class BlogsController < ApplicationController
  before_action :logged_in?, only: [:edit, :destroy]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
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
    @blog = current_user.blogs.build(blog_params) #これは、blog new - @blog = Blog.new(blog_params)　とほとんど同じ。However, by writing the first way, the app knows at this stage, what criteria has been populated.
    if params[:back]
      render :new
    else
      if @blog.save
        BlogMailer.blog_mail(@blog).deliver ##
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end

    # @blog = Blog.new(blog_params)
    # if @blog.save
    #   BlogMailer.blog_mail(@blog).deliver
    #   redirect_to blogs_path, notice: 'Blog was successfully created.'
    # else
    #   render :new
    # end
  end

  def edit
    # if logged_in? == true
    #   @blog = Blog.find(params[:id])
    # else
    #   redirect_to new_user_path, notice: "ログインするか新規ユーザー設定後Blogをご使用下さい。"
    # end
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
  def logged_in?
    unless current_user.present?
      redirect_to new_user_path, notice: "ログインするか新規ユーザー設定後Blogをご使用下さい。"
    end
  end

  def blog_params
   params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

end
