require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  ##Index Action
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  ##New Actions
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "recipes/#{@recipe.id}"
  end

  ##Show Action
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  ##Update Actions
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    erb :show
  end

  ##Delete Action
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    # @msg = "#{@recipe.name} was deleted"
    # redirect to "/recipes?msg=#{@msg}"
    redirect to '/recipes'
  end

  # post '/recipes/:id/delete' do
  #   "Hello World"
  # end

end
