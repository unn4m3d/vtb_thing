class Attempts::Create < BrowserAction
  post "/attempts" do
    SaveAttempt.create(params) do |operation, attempt|
      if attempt
        flash.success = "The record has been saved"
        redirect Show.with(attempt.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
