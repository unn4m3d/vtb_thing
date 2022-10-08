class Items::Show < BrowserAction
  get "/items/:item_id" do
    html ShowPage, item: ItemQuery.find(item_id)
  end
end
