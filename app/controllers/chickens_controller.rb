class ChickensController < ApplicationController
# move this to a new HOME CONTROLLER for home/indrex only according to assignment

  # before_action :is_authenticated?
    # This code is for protected pages and is stored in Application Controller!
    # Adding a chicken and user profile are only protected pages
    # @user = User.find_by_id(session[:user_id])
 before_action :is_authenticated?
    # redirect_to login_path unless @user

  def chickens
    @chicken = Chicken.all
  end

  def index
    @chicken = Chicken.all
    @current_user = @current_user
  end


  def new
    @tags = Tag.all
    @chicken = Chicken.new
  end

  def update

    @chicken = Chicken.find(params[:id]) or not_found

    if @chicken.update_attributes(params.require(:chicken).permit(:name, :desc))
      redirect_to '/chickens'
    else
      render 'index'
    end

    @chicken.tags.clear

    @tags = params[:chicken][:tag_ids].split(',')

        @tags.each do |tag|
          # binding.pry
          # Tag.find_or_create_by(name: tag)

          @chicken.tags << Tag.find_or_create_by(name: tag) unless tag.blank?
        end

  end

  def destroy
    c = Chicken.find_by_id(params[:id]) or not_found
    c.destroy
    redirect_to chickens_path
  end

  def create
      @tags = Tag.all
      @chicken = Chicken.new(params.require(:chicken).permit(:name, :breed, :desc))
      if @chicken.save
        flash[:success] = "Your chicken has been added."
        @chicken.tags.clear

        tags = params[:chicken][:tag_ids].split(',')

        tags.each do |tag|
          # binding.pry
        Tag.find_or_create_by(name: tag)

          @chicken.tags << Tag.find_by_name(tag) unless tag.blank?
        end
        #flash success is a BOOTSTRAP term related to "alert-success" class.
        #Look at erb file index to show how it's called via the first param / key
        #I created a PARTIAL for all flash messages! See Partials + index view to connect dots
        redirect_to '/chickens'
      else
        render 'new'
      end
  end

  def show

    @chicken = Chicken.find_by_id(params[:id])
    not_found unless @chicken #carries error

    @search = @chicken.breed
    list = flickr.photos.search :text => @search+" "+"chicken", :sort => "relevance"

    list2 = flickr.photos.search :text => @search+" "+"chicken", :sort => "relevance"

    @results = list.map do |photo|
      FlickRaw.url_m(photo)
    end

    @response = RestClient.get 'http://www.reddit.com/search.json', {:params => {:q => @search, :limit => 10}}
    @response_object = JSON.parse(@response)
    @reddit_posts = @response_object['data']['children']
  end

  def tag
    tag = Tag.find_by_name(params[:tag])
    if tag
      @chickens = tag.chickens
    else
      @chickens = []
    end

  end

  def edit

    @chicken = Chicken.find_by_id(params[:id]) or not_found
    @tags = @chicken.tags

  end

end