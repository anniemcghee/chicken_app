class ChickensController < ApplicationController
# move this to a new HOME CONTROLLER for home/indrex only according to assignment

  def chickens
    @chicken = Chicken.all
  end

  def index
    @chicken = Chicken.all
  end


  def new
    @chicken = Chicken.new
  end

  def update
   @chicken = Chicken.find(params[:id]) or not_found
    if @chicken.update_attributes(params.require(:chicken).permit(:name, :desc))
      redirect_to '/chickens'
    else
      render 'index'
    end
  end

  def destroy
    c = Chicken.find(params[:id]) or not_found
    c.destroy
    redirect_to '/'
  end

  def create
      @chicken = Chicken.new(params.require(:chicken).permit(:name, :breed, :desc))
      if @chicken.save
        redirect_to '/chickens'
      else
        render 'new'
    end
  end

  def show
    @chicken = Chicken.find(params[:id]) or not_found

    @search = @chicken.breed
    list = flickr.photos.search :text => @search+" "+"chicken", :sort => "relevance"

    list2 = flickr.photos.search :text => @search+" "+"chicken", :sort => "relevance"

    @results = list.map do |photo|
      FlickRaw.url_m(photo)
    end

  end

  def edit
    @chicken = Chicken.find(params[:id]) or not_found
  end

end