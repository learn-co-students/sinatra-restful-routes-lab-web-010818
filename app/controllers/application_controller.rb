class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipes = Recipe.all
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes' do
  #  @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipes = Recipe.all
    erb :'recipes.html'
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :'show.html'
  end

  get '/recipes/:id/edit' do
      id = params[:id].to_i
      @recipe = Recipe.find(id)
    erb :'edit.html'
  end

  patch '/recipes/:id' do
    id = params[:id].to_i
    @recipe = Recipe.find(id)
    @recipe.name = params["name"]
    @recipe.ingredients = params["ingredients"]
    @recipe.cook_time = params["cook_time"]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    erb :index
  end


end
