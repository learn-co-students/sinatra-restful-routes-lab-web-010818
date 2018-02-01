class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #LOADS A FORM FOR NEW RECIPE
    get '/recipes/new' do
      erb :new
    end

  #ALL RECIPES - index page
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end


  # REST route for a single recipe - loads show page
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  #REST route to edit a single recipe
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

#UPDATES
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    # erb :show
    redirect to "/recipes/#{@recipe.id}"
  end

  #CREATE NEW RECIPE
    post '/recipes' do
      @recipe = Recipe.create(params)
      redirect to "/recipes/#{@recipe.id}"
    end
    # redirect to '/recipes/#{@recipe.id}'

  #DELETE RECIPE BUTTON
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end



end
