require'pry'

class ApplicationController < Sinatra::Base
    set :public_folder, 'public'
    set :views, 'app/views'


  #NEW/CREATE ACTION-----------------------------------
  get '/recipes/new' do
      erb :'/new.html'
  end

  post '/recipes' do
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end


  #SHOW ONE ACTION-------------------------------------
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :'/show.html'
  end


  #INDEX ACTION----------------------------------------
   get '/recipes' do
     @recipes = Recipe.all
     erb :'/index.html'
   end


  #EDIT ACTION-----------------------------------------
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :'/edit.html'
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = (params[:name])
    @recipe.ingredients = (params[:ingredients])
    @recipe.cook_time = (params[:cook_time])
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  #DELETE ACTION----------------------------------------
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
