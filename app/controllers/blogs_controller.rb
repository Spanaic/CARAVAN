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
    @blog = Blog.find(params[:id])
    # blog.update
    # redirect_to blog_path

    # updateはedit内の一つではなく、アクションの一つだと覚えておく。
    # 書く場所は間違えたけど、記述はほぼほぼ合ってる。
    # Link＿to”編集”がクリックされた際に実行されるアクションがedit.
    # モデルに指示を出してdbからデータを引っ張ってきて”表示”する（※@が必要な理由）

  end

  def update
    blog = Blog.find(params[:id])
    # もしかしてリダイレクト処理が入ると、新しいviewファイルを呼び出さないので、インスタンス変数ではなくローカル変数を使う・・・？
    blog.update(blog_params)
    # blog_paramsで更新内容を制限する。createの時と同じ。
    # edit.html.erbで保存（更新）をクリックされたときに呼び出されるアクション
    # モデルに指示を出してdbからデータを引っ張り出す
    # .update(blog_params)メソッドで上書きして格納
    redirect_to blog_path(blog)
    # 処理後はshow.html.erbへとリダイレクト
    # blogs_pathはshow.htme.erbの名前付きルート
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    # なんでdestroyするときに[blog_params]使わないの？
    # ==＞ストロングパラメータはフォームを使う際に、モデルを渡す時の”チェック係”のようなもの
    # デストロイ時はモデルをフォームに渡したりしないので(blog_params)のようなストロングパラメータを使う必要がない
    # (params[:id])はストロングパラメータとは関係ない。
    redirect_to blogs_path
  end

end

private

def blog_params
  params.require(:blog).permit(:title, :category, :body)
  # 区切りには"."を使う。requireするのはモデル名（コントローラ名：blogs）
  # 許可するカラム名の区切りには”,”を使う
end
