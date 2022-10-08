class Transactions::Edit < BrowserAction
  get "/transactions/:transaction_id/edit" do
    transaction = TransactionQuery.find(transaction_id)
    html EditPage,
      operation: SaveTransaction.new(transaction),
      transaction: transaction
  end
end
