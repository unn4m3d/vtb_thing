class Transactions::Index < BrowserAction
  get "/transactions" do
    html IndexPage, transactions: TransactionQuery.new
  end
end
