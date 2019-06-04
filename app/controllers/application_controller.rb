
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        set :method_overide, true
    end

    get '/' do
        redirect '/articles'
    end

    get '/articles' do
        @articles = Article.all
        erb :index
    end

    get '/articles/new' do
        erb :new
    end

    post '/articles' do
        new = Article.create(title: params[:title], content: params[:content])
        redirect "/articles/#{new.id}"
    end

    get '/articles/:id' do
        @article = Article.find(params[:id])
        erb :show
    end

    get '/articles/:id/edit' do
        @article = Article.find(params[:id])
        erb :edit
    end

    patch '/articles/:id' do
        @article = Article.find(params[:id])
        @article.update(title: params[:title], content: params[:content])
        redirect "/articles/#{@article.id}"
    end

    delete '/articles/:id' do
        Article.delete(params[:id])
        redirect "/articles"
    end

end
