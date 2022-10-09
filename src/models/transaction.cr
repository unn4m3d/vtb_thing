class Transaction < BaseModel
  table do
    column title : String
    column fromw : String
    column tow : String
    column content : String
    column status : WalletHelper::TransactionStatus
    column hash : String?
    belongs_to chained : Transaction?
  end


  def transaction_status
    if status.deferred?
      WalletHelper::TransactionStatus::Deferred
    else
      WALLET.status hash.not_nil!
    end
  end

  def t_type
    type, _, _ = content.partition(':')
    type
  end

  def desc
    _, _, info = content.partition(':')

    return info
  end

  def apply
    th = case t_type.downcase
    when "rub"
        WALLET.transfer_rub(fromw, tow, desc.to_i32)
    when "nft"
        WALLET.transfer_nft(fromw, tow, desc.to_i32)
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
    TransactionQuery.preload_chained(self).chained.try &.apply
  end

  def failure_hook
    if t_type == "nft"
      nft = ItemQuery.find(desc.to_i64)

      if nft.status.locked?
        SaveItem.update(nft, current_user: UserQuery.find(1), status: Item::Status::Active) {|_,_|}
      end
    end
  end
end
