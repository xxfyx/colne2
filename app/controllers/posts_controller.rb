class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
     @posts = Post.all.order("created_at DESC")

  end

  def show  
   @PostOwner = User.find_by_id(@post.user_id)
   # @pospics = Picture.where(post_id: @post)
   @postpics = @post.pictures
  end

  def myposts
    @myposts = Post.where( :user_id => current_user.id ).order("created_at DESC")
  end
  

  def new
    @post = current_user.posts.build
    @post.pictures.build
  end

  def create

    @post = current_user.posts.build(post_params)

     
    if @post.save
       if params[:images]
        params[:images].each { |image|
          @post.pictures.create(image: image)
        }
      end
      redirect_to root_path
    else
      redirect_to new_post_path 
    end     
  end

  def edit
    if @post.user_id == current_user.id
        render 'edit'
      else
        redirect_to root_path
      
    end
  end



  def update
    
  end

  def destroy
    if @post.destroy
      redirect_to myposts_posts_path
    else
      render 'show'
    end
  end

  private

  def post_params
       params.require(:post).permit( :title, :price, :description, :phone, :city, pictures_attributes: [:image] )
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
