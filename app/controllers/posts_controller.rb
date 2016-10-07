class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :search]
  def index
     @posts = Post.all.order("created_at DESC").paginate(:page => params[:page],  :per_page => 10)
  end

def search
    if params[:search].presence || params[:category_id].presence || params[:city_id].presence
      search = params[:search].presence || "*"
      conditions = {}
      conditions[:category_id] = params[:category_id] if params[:category_id].present?
      conditions[:city_id] = params[:city_id] if params[:city_id].present?

      @posts = Post.search search, where: conditions, aggs: [:category,:city], order: {updated_at: :desc}
    else
    redirect_to root_path
    end
end


  def show
   @PostOwner = User.find_by_id(@post.user_id)
   # @pospics = Picture.where(post_id: @post)
   @postpics = @post.pictures
  end

  def myposts
    @myposts = Post.where( :user_id => current_user.id ).order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end


  def new
    @post = current_user.posts.build
    @post.pictures.build

  end

  def create

    @post = current_user.posts.build(post_params)
    @post.category_id = params[:post][:category_id]
    @post.city_id = params[:post][:city_id]

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
    @post
    if @post.user_id == current_user.id
        render 'edit'
      else
        redirect_to root_path

    end
  end



  def update
    if @post.user_id == current_user.id
    @post.category_id = params[:category_id]
    @post.update(post_params)
      redirect_to @post
      else
        redirect_to root_path
    end
  end

  def destroy
     if @post.user_id == current_user.id
        @post.destroy
        redirect_to myposts_posts_path
    else
     redirect_to root_path
    end
  end

  private

  def post_params
       params.require(:post).permit( :title, :price, :description, :phone, :city_id, :category_id, pictures_attributes: [:image] )
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
