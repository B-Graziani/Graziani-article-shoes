class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @articles = policy_scope(Article)
  end

  def show
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.save
    authorize @article
    redirect_to article_path(@article)
  end


  def edit
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  private

  def set_article
      @article = Article.find(params[:id])
      authorize @article
    end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
