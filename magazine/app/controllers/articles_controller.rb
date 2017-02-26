class ArticlesController < ApplicationController

	# a user must be logged in before accessing articles
	before_action :authenticate_user

	def create
		@article = Article.new(article_params.merge(:user_id => current_user.id))

		if @article.save
			# save article's tags and sub tags only after the article is saved successfully
			@article.tag_list = params[:article][:tag_list]
			@article.sub_tag_list = params[:article][:sub_tag_list]
			redirect_to @article
		else
			render 'new'
		end
	end

	def new
		@article = Article.new
	end

	def show
  		@article = Article.find(params[:id])
  	end

  	def index
  		@home_page = true
  		@articles = if params[:lookup]
  			Article.search(params[:lookup])
  		else
  			# To avoid N+1 query problem in view, eager_loading is used instead of joins
			@article = Article.eager_load([:tags, :sub_tags, :taggings])
		end
  	end

  	def edit
  		@article = Article.find(params[:id])
  	end

  	def update
  		@article = Article.find(params[:id])
 		if @article.update(article_params)
 			# update tag list and sub tag list if article is updated
 			@article.tag_list = params[:article][:tag_list]
 			@article.sub_tag_list = params[:article][:sub_tag_list]
	    	redirect_to @article
	  	else
	    	render 'edit'
	  	end
  	end

  	private

	def article_params
    	params.require(:article).permit(:title, :description, :lookup)
	end

end
