class Items::Edit < BrowserAction
  get "/items/:item_id/edit" do
    item = ItemQuery.find(item_id)
    html EditPage, operation: SaveItem.new(item, current_user: current_user), item: item
  end
end
