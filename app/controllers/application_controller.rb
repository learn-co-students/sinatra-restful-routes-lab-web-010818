class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'index.html'
  end

  get '/recipes/new' do
    erb :'new.html'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :'index.html'
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    @recipes = Recipe.all
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    id = params[:id].to_i
    @recipe = Recipe.find(id)
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
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time] )
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    id = params[:id].to_i
    @recipe = Recipe.find(id)
    @recipe.destroy
    erb :'delete.html'
  end


end
