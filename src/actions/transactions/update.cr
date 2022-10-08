class Transactions::Update < BrowserAction
  put "/transactions/:transaction_id" do
    transaction = TransactionQuery.find(transaction_id)
    SaveTransaction.update(transaction, params) do |operation, updated_transaction|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updated_transaction.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, transaction: updated_transaction
      end
    end
  end
end
