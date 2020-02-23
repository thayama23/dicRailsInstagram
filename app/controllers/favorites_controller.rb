class FavoritesController < ApplicationController
  before_action :logged_in?, only: [:index]

  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_url, notice: "#{favorite.blog.user.name}さんのブログをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to blogs_url, notice: "#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
  end

  def index
    # @user = User.find(params[:id])
    @favorite_blogs = current_user.favorite_blogs
  end

  private
  def logged_in?
    unless current_user.present?
      redirect_to new_user_path, notice: "ログインするか新規ユーザー設定後Blogをご使用下さい。"
    end
  end

end
