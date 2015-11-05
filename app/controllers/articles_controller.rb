class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit,:update,:show,:destroy]
  before_action :require_same_user, only:[:edit,:update,:destroy,:show,]


  def new
    @article = Article.new
  end



  def create
    @article = Article.new(article_params)
    @article.user  = current_user

   if @article.save
      flash[:notice] = "Article was successfully created"
      #redirect_to article_path(@article)
    else
     render 'new'
    #render plain: params[:article].inspect
   # @article = Article.new(article_params)
  #  @article.save
   # redirect_to article_path(@article)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
      @article = Article.all
      @article= Article.find(params[:id])
      @article.update_attributes(article_params)
    # if @article.update(article_params)
    #  flash[:notice] = "Article was successfully updated"
    #  @article = Article.all

      #redirect_to article_path(@article)
   # else
    #  render 'edit'
 #   end
  end

  def delete
    @article = Article.find(params[:article_id])

  end


  def destroy
    @user = @article.user
    @article.destroy
    flash[:notice] = "Article was successfully updated"
    #redirect_to user_path(@user)
  end



  private
   def article_params
     params.require(:article).permit(:title,:description)
   end



  private
   def set_article
     @article = Article.find(params[:id])
   end

  private
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can only edit or delete you own articles"
      redirect_to root_path
    end



  end












end