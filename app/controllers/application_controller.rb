class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

  delete ("/reviews/:id") do  
    #find the review passed in params
    #delete that review
    #send the deleted review back as json for the tReact app to consume and show confirmation that it was deleted
    id = params[:id].to_i
    review = Review.find(id)
    review.destroy  #This is the delete call
    review.to_json  #return the deleted review
  end

  post("/reviews") do
    review = Review.create(  
      #Remember that all these are parameters 
      id:params[:id],
    score:params[:score],
    comment:params[:comment],
    game_id:params[:game_id],
    user_id:params[:user_id]
    )
    review.to_json
  end


  patch("/reviews/:id") do
    #find the review to update
    #Access the data in the request body
    #Use the data to update the review in the db
    #return the updated review back to the frontend client
    id = params[:id].to_i
    review = Review.find(id)
    review.update(
      score: params[:score],
      comment: params[:comment]
    )

    review.to_json
  end

end
