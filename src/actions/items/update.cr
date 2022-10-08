class Items::Update < BrowserAction
  put "/items/:item_id" do
    item = ItemQuery.find(item_id)
    SaveItem.update(item, params, current_user: current_user) do |operation, updated_item|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updated_item.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, item: updated_item
      end
    end
  end
end
