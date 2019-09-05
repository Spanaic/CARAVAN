class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
    # newにはparamsを指定しなくてOK
  end

  def create
    blog = Blog.new(blog_params)
    # 変数はローカルでOK、viewには渡さないため
    blog.save
    #大文字にしなくてOK
    redirect_to blogs_path
    # blogs_pathがどこから登場したのか不明

  end

  def edit
    blog = Blog.find(params[:id])
    blog.update
    redirect_to blog_path
  end

  # def destroy
  #   redirect_to blogs_path
  # end

end

private

def blog_params
  params.require(:blog).permit(:title, :category, :body)
  # 区切りには"."を使う。requireするのはモデル名（コントローラ名：blogs）
  # 許可するカラム名の区切りには”,”を使う
end
