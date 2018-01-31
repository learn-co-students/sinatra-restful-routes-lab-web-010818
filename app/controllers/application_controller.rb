class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find(id)
    erb :show
  end

  get '/recipes/:id/edit' do
    id = params[:id]
    @recipe = Recipe.find(id)
    erb :edit
  end

  patch '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find(id)
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    id = params[:id]
    @recipe = Recipe.find(id)
    @recipe.delete
    redirect to '/recipes'
  end



end
