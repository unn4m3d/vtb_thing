class Me::Show < BrowserAction
  get "/me" do    
    html ShowPage, transactions: TransactionQuery.new.fromw(current_user.wallet_privkey).or(&.tow(current_user.wallet_pubkey)).order_by(:id, :desc).limit(3)
  end
end
