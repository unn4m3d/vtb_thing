class Items::Create < BrowserAction
  post "/items" do
    SaveItem.create(params) do |operation, item|
      if item
        flash.success = "The record has been saved"
        redirect Show.with(item.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
