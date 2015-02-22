class ArticlesController < ApplicationController

	
	def index
		@articles = Article.all
	end
	
	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
		5.times { @article.tags.build }
	end
	
	def edit
		@article = Article.find(params[:id])
	end

	def create
   @article = Article.new()
   tag_attr = article_params[:tags_attributes]
   tag_attr2 = article_params.except("tags_attributes")
   list_of_tag_id={}
   tag_attr.each_value { |attr|
   	if current_tag = Tag.find_by(tag: attr["tag"])
   		current_tag.add_to_set(article_ids: @article._id)	
   		list_of_tag_id[tag_attr.index(attr)]=current_tag._id
   		tag_attr.except!(tag_attr.index(attr))
   	end
   }
   tag_attr2["tags_attributes"]=tag_attr
   @article.update_attributes(tag_attr2)
   list_of_tag_id.each do |tag_id|
   	@article.add_to_set(tag_ids: tag_id)
   end   	

   if @article.save
		redirect_to @article
   else
		render 'new'
   end
	end
	 
	def update
	  @article = Article.find(params[:id])
	  if @article.update_attributes(article_params)
			redirect_to @article
		else
		render 'edit'
	  end
	end
	
	def destroy
	  @article = Article.find(params[:id])
	  @article.destroy
	 
	  redirect_to articles_path
	end

	private
		def article_params
			params.require(:article).permit(:title, :text, tags_attributes: [:id, :tag, :_destroy])
		end
		
		def tag_params
			params.require(:article).permit(:tag)
		end
		
	
end
