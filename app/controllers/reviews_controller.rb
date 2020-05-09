class ReviewsController < ApplicationController

  def index
    # this is our list page for our reviews
    @price = params[:price]
    @cuisine = params[:cuisine]
    @location = params[:location]
#start withh all reviews
@reviews = Review.all

  #filter by price
    if @price.present?
      @reviews = @reviews.where(price: @price)
    end
    #filter by cuisine
    if @cuisine.present?
      @reviews = @reviews.where(cuisine: @cuisine)
    end

    # search near the location
    if @location.present?
      @reviews = @reviews.near(@location)
    end

  end




  def new
    #form for adding new review
    @review = Review.new
  end

  def create
    #take info from form and add to model
    @review = Review.new(form_params)
    #check if model can be saved
    #if it is, go homepage again
    #if it isnt, show new form

    if @review.save
      redirect_to root_path
    else
      #show the view for new.html.erb
      render "new"
    end
  end

  def show
    #individual review page
    @review = Review.find(params[:id])

  end

  def destroy
    #find individual review
    @review = Review.find(params[:id])

    #destroy
    @review.destroy

    #redirect to homepage
    redirect_to root_path

  end

  def edit
    #find individual review to edit
    @review = Review.find(params[:id])
  end

  def update
    #find individual review
    @review = Review.find(params[:id])

    #update with new info from form
    if @review.update(form_params)

      #redirect somewhere new
      redirect_to review_path(@review)
    else
        render "edit"

      end

  end

  def form_params
    params.require(:review).permit(:title, :restaurant, :body, :score, :ambiance, :cuisine, :price, :address)

  end
end
