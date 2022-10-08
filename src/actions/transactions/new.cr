class Transactions::New < BrowserAction
  get "/transactions/new" do
    html NewPage, operation: SaveTransaction.new
  end
end
