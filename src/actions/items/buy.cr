class Items::Buy < BrowserAction
    get "/items/:item_id/buy" do
      begin
        CreateTransaction.buy_nft(current_user.wallet_helper, ItemQuery.find(item_id))
        flash.success = "Транзакция создана! Обмен состоится в течение нескольких минут..."
        redirect to: Me::Show
      rescue e
        flash.failure = e.to_s
        redirect to: Index
      end
    end
  end
  