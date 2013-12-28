class TransferLineItem < ActiveRecord::Base
  belongs_to :account
  belongs_to :container
  belongs_to :transfer
end
