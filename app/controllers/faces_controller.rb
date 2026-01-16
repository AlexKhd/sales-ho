class FacesController < ApplicationController
  before_action :set_face, only: [ :show, :edit, :update ]

  def index
    @faces = Face.all.order(:fid)
  end

  def edit
  end

  def show
  end

  def update
  end

  private
    def set_face
      @face = Face.find_by!(fid: params[:id])
    end
end
