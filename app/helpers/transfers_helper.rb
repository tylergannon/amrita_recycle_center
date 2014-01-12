module TransfersHelper
  def transfer_form_title
    if @transfer.debit.location && @transfer.debit.category
      "Materials Transfer from #{@transfer.debit.location.name} / #{@transfer.debit.category.name}"
    else
      "New Materials Transfer"
    end
  end
end
