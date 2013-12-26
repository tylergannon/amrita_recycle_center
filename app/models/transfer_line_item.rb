class TransferLineItem < ActiveRecord::Base
  belongs_to :account
  belongs_to :container
end
