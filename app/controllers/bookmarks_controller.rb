class BookmarksController < ApplicationController

  def index
    
  end

  def create

  end

  def destroy

  end
  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

  def find_bookmark
    @bookmark = Bookmark.find(params[:id])
  end
end
