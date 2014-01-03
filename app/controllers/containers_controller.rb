class ContainersController < ApplicationController
  before_action :set_container, only: [:show, :edit, :update, :destroy]

  def index
    @containers = Container.all
    respond_with(@containers)
  end

  def show
    respond_with(@container)
  end

  def new
    @container = Container.new
    respond_with(@container)
  end

  def edit
  end

  def create
    @container = Container.new(container_params)
    @container.save
    respond_with(@container)
  end

  def update
    @container.update(container_params)
    respond_with(@container)
  end

  def destroy
    @container.destroy
    respond_with(@container)
  end

  private
    def set_container
      @container = Container.friendly.find(params[:id])
    end

    def container_params
      params.require(:container).permit(:name, :capacity, :empty_weight)
    end
end
