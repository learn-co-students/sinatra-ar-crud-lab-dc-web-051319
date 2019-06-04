# frozen_string_literal: true

require_relative '../../config/environment'

set :method_override, true

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    title = params['title']
    content = params['content']
    article = Article.create(title: title, content: content)
    redirect "articles/#{article.id}"
  end

  get '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end

  patch '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    title = params['title']
    content = params['content']
    @article.update(title: title, content: content)
    redirect "articles/#{@article.id}"
  end

  delete '/articles/:id' do
    id = params[:id]
    Article.delete(id)
    redirect 'articles'
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    erb :edit
  end
end
