
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  set :method_override, true

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    title = params["title"]
    content = params["content"]
    article = Article.create(title: title, content: content)
    redirect "articles/#{article.id}"
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id/edit' do
    id = params["id"]
    @article = Article.find(id)
    erb :edit
  end

  get '/articles/:id' do
    id = params["id"]
    @article = Article.find(id)
    erb :show
  end

  patch '/articles/:id' do
    id = params["id"]
    title = params["title"]
    content = params["content"]
    @article = Article.find(id)
    @article.update(title: title, content: content)
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    id = params["id"]
    article = Article.find(id)
    article.delete
    redirect "/articles"
  end



end
