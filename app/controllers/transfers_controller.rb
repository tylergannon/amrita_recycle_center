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
    
    @credits = [@transfer.transfer_line_items.build(credit: true)]
    # @transfer.transfer_line_items.build
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
    
    respond_with(@transfer)
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

  private
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    def transfer_params
      params.require(:transfer).permit(:transferred_at, {transfer_line_items_attributes: %i(location_id category_id container_id transfer_id gross_weight)},
              debit_attributes: %i(location_id category_id))
    end
end
