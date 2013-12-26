class TransferLineItemsController < ApplicationController
  before_action :set_transfer_line_item, only: [:show, :edit, :update, :destroy]

  def index
    @transfer_line_items = TransferLineItem.all
    respond_with(@transfer_line_items)
  end

  def show
    respond_with(@transfer_line_item)
  end

  def new
    @transfer_line_item = TransferLineItem.new
    respond_with(@transfer_line_item)
  end

  def edit
  end

  def create
    @transfer_line_item = TransferLineItem.new(transfer_line_item_params)
    @transfer_line_item.save
    respond_with(@transfer_line_item)
  end

  def update
    @transfer_line_item.update(transfer_line_item_params)
    respond_with(@transfer_line_item)
  end

  def destroy
    @transfer_line_item.destroy
    respond_with(@transfer_line_item)
  end

  private
    def set_transfer_line_item
      @transfer_line_item = TransferLineItem.find(params[:id])
    end

    def transfer_line_item_params
      params.require(:transfer_line_item).permit(:credit, :account_id, :container_id, :gross_weight, :net_weight)
    end
end
