class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy, :retrieve]

  def index
    @feeds = Feed.all
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def edit
  end

  def retrieve
    body, ok = SuperfeedrEngine::Engine.retrieve(@feed)
    if !ok
      redirect_to @feed , notice: body
    else
      @feed.notified JSON.parse(body)
      redirect_to @feed , notice: "Feed atualizado com sucesso!"
    end
  end

  def create
    @feed = Feed.new(feed_params)
    
    existeFeed = Feed.find_by(url: @feed.url, user_id: @feed.user_id )
    
    if existeFeed.nil?
      if @feed.save
        body, ok = SuperfeedrEngine::Engine.subscribe(@feed, {:retrieve => true})
        if !ok
          redirect_to @feed, notice: "Feed cadastrado com sucesso, mas nao carregado. #{body}"
        else
          if body
            @feed.notified JSON.parse(body)
          end
          redirect_to @feed, notice: 'Feed cadastrado e carregado com sucesso!'
        end
      else
        render :new
      end
    else
      redirect_to '/feeds/new', notice: 'Feed ja cadastrado para este usuario!'
    end
    
  rescue => e
    @feed.destroy

    redirect_to '/feeds/new', notice: "Nao foi possivel realizar sua solicitacao, verifique se a URL eh valida (Ex: http://www...)"

  end

    def update
      
    id = @feed.id
    existeFeed = Feed.find_by(url: :url, user_id: :user_id )

    if existeFeed.nil?
      if @feed.update(feed_params)
        body, ok = SuperfeedrEngine::Engine.unsubscribe(@feed)
        if !ok
          render :edit, notice: "Feed alterado com sucesso, mas nao foi possivel recarrega-lo. #{body}"
        else
          body, ok = SuperfeedrEngine::Engine.subscribe(@feed)
          if !ok
            render :edit, notice: "Feed alterado com sucesso, mas nao foi possivel recarrega-lo. #{body}"
          else
            redirect_to @feed, notice: 'Feed alterado com sucesso!'
          end
        end
      else
        render :edit
      end
      
    else
      url = "/feeds/" + existeFeed.id.to_s + "/edit"
      redirect_to url , notice: "Feed ja cadastrado para esse usuario."
    end  
  
    rescue => e
      url = "/feeds/" + id.to_s + "/edit"
      redirect_to url , notice: "Nao foi possivel realizar sua solicitacao, verifique se a URL eh valida (Ex: http://www...)"
    
  end

  def destroy
    body, ok =  SuperfeedrEngine::Engine.unsubscribe(@feed)
    if !ok
      redirect_to @feed, notice: body
    else
      @feed.destroy
      redirect_to feeds_url, notice: 'Feed excluido com sucesso!'
    end
    
    rescue => e
    @feed.destroy
    redirect_to feeds_url, notice: 'Feed excluido com sucesso!'
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:title, :url, :user_id)
    end
end