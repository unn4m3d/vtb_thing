class SaveTransaction < Transaction::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  permit_columns title, fromw, tow, content, hash, status, chained_id
end

class CreateTransaction < Transaction::SaveOperation
  permit_columns title, fromw, tow, content, hash, status, chained_id

  def self.buy_nft(wh, item)
    tr = CreateTransaction.create!(
        title: "Buy #{item.identifier}",
        fromw: WALLET.privkey,
        tow: wh.pubkey,
        content: "nft:#{item.token_id}",
        status: WalletHelper::TransactionStatus::Deferred) 
    CreateTransaction.create!(
      title: "Buy #{item.identifier}",
      fromw: wh.privkey,
      tow: WALLET.pubkey,
      content: "rub:#{item.price}",
      hash: WALLET.transfer_rub(wh.privkey, WALLET.pubkey, item.price),
      status: WalletHelper::TransactionStatus::Pending,
      chained_id: tr.not_nil!.id
    )
    end
end
