class TagsController < ApplicationController
  def index
	@article = Article.new
  end

  def show
    @tag = Tag.find(params[:id])
    @articles_by_tag = @tag.articles
  end
  
  def create
    @article = Article.find(params[:article_id])

    if current_tag = Tag.find_by(tag: tag_params["tag"])
      current_tag.add_to_set(article_ids: @article._id) 
      @article.add_to_set(tag_ids: current_tag._id)
    else
      @tag = @article.tags.create(tag_params)
    end
    redirect_to article_path(@article)
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @tag = @article.tags.find(params[:id])
    @tag.destroy
    redirect_to article_path(@article)
  end
 
  private
    def tag_params
      params.require(:tag).permit(:tag)
    end
end
