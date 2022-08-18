class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]

  def index
    articles = Article.all
    render json: articles
  end

  def show
    if @article.nil?
      render json: nil, status: :not_found
    else
      render json: @article
    end
  end

  def create
    article = Article.new(post_params)
    if article.save
      render json: article, status: :created
    else
      render json: article.errors, status: :unprocessable_entity
    end
  end

  def update
    if @article.nil?
      render json: nil, status: :not_found
    elsif @article.update(post_params)
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.nil?
      render json: nil, status: :not_found
    elsif Article.destroy(@article.id)
      render json: @article
    else
      render json: @article.errors, status: :conflict
    end
  end

  private

  def post_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find_by(id: params[:id])
  end

end
