class Items::Create < BrowserAction
  post "/items" do
    SaveItem.create(params, token_id: 0, current_user: current_user) do |operation, item|
      if item
        flash.success = "The record has been saved"
        result = WALLET.gen_collection(item.uri, 1)
        redirect Show.with(item.id)
      else
        flash.failure = "It looks like the form is not valid"

        operation.errors.each do |x| puts x.to_s end
        html NewPage, operation: operation
      end
    end
  end
end
