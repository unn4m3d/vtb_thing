class Attempts::Delete < BrowserAction
  delete "/attempts/:attempt_id" do
    attempt = AttemptQuery.find(attempt_id)
    DeleteAttempt.delete(attempt) do |_operation, _deleted|
      flash.success = "Deleted the attempt"
      redirect Index
    end
  end
end
