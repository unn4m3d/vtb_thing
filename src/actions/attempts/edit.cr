class Attempts::Edit < BrowserAction
  get "/attempts/:attempt_id/edit" do
    attempt = AttemptQuery.find(attempt_id)
    html EditPage,
      operation: SaveAttempt.new(attempt),
      attempt: attempt
  end
end
