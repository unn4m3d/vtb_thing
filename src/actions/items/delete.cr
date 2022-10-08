class Items::Delete < BrowserAction
  delete "/items/:item_id" do
    item = ItemQuery.find(item_id)
    DeleteItem.delete(item) do |_operation, _deleted|
      flash.success = "Deleted the item"
      redirect Index
    end
  end
end
