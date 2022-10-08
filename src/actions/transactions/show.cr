class Transactions::Show < BrowserAction
  get "/transactions/:transaction_id" do
    html ShowPage, transaction: TransactionQuery.find(transaction_id)
  end
end
