class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def index
    @transfers = Transfer.all
    respond_with(@transfers)
  end

  def show
    respond_with(@transfer)
  end

  def new
    @transfer = Transfer.new
    @debit = @transfer.debit
    @debit.set_category_by_id from_params[:category_id]
    @debit.set_location_by_id from_params[:location_id]
    
    if params[:worksheet]
      @worksheet = params[:worksheet]
    end
    
    credit = @transfer.transfer_line_items.build(credit: true)
    credit.set_container_by_id to_params[:container_id]
    credit.set_location_by_id to_params[:location_id]
    credit.set_category_by_id to_params[:category_id]
    @credits = [credit]

    respond_with(@transfer)
  end

  def edit
  end

  def create
    @transfer = Transfer.new
    # @transfer.transfer_line_items.build gross_weight: -10, container: Container.no_container
    @transfer.attributes = transfer_params
    
    @transfer.balance!
    @transfer.save
    
    respond_with(@transfer) do |format|
      format.html {
        if params[:worksheet]
          redirect_to worksheet_path(params[:worksheet]) 
        else
          redirect_to @transfer
        end
      }
    end
  end

  def update
    @transfer.attributes = transfer_params
    @transfer.balance!
    @transfer.save
    respond_with(@transfer)
  end

  def destroy
    @transfer.destroy
    respond_with(@transfer)
  end
  
  def from_params
    if params[:from]
      params.require(:from).permit %i(location_id category_id)
    else
      {}
    end
  end
  
  def to_params
    if params[:to]
      params.require(:to).permit %i(location_id container_id category_id)
    else
      {}
    end
  end

  private
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    def transfer_params
      params.require(:transfer).permit(:transferred_at, {transfer_line_items_attributes: %i(location_id category_id container_id transfer_id gross_weight)},
              debit_attributes: %i(location_id category_id))
    end
end
