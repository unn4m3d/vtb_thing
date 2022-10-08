class Transaction < BaseModel
  table do
    column title : String
    column fromw : String
    column tow : String
    column content : String
    column status : WalletHelper::TransactionStatus
    column hash : String
    belongs_to chained : Transaction?
  end


  def transaction_status
    if status.deferred?
      WalletHelper::TransactionStatus::Deferred
    else
      WALLET.status hash
    end
  end

  def apply
    type, _, info = content.partition(':')

    th = case type.downcase
    when "rub"
        WALLET.transfer_rub(fromw, tow, info.to_i32)
    when "nft"
        WALLET.transfer_nft(fromw, tow, info.to_i32)
    else
        ""
    end

    unless th.empty?
      SaveTransaction.update(self, hash: th, status: WalletHelper::TransactionStatus::Pending) do |op, _|
        # ...
      end
    end
  end

  def success_hook
    chained.not_nil!.apply unless chained.nil?
  end

  def failure_hook

  end
end
