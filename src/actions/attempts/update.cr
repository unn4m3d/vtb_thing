class Attempts::Update < BrowserAction
  put "/attempts/:attempt_id" do
    attempt = AttemptQuery.find(attempt_id)
    SaveAttempt.update(attempt, params) do |operation, updated_attempt|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updated_attempt.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, attempt: updated_attempt
      end
    end
  end
end
