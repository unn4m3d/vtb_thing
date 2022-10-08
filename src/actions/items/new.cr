class Items::New < BrowserAction
  get "/items/new" do
    html NewPage, operation: SaveItem.new
  end
end
