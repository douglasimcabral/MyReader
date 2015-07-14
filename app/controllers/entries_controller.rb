class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :destroy]

  def index
    @entries = Entry.all
  end

  def show
  end

  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Noticia excluida com sucesso!' }
      format.json { head :no_content }
    end
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:feed_id, :atom_id, :title, :url, :content)
    end
end