class Attempts::Show < BrowserAction
  get "/attempts/:attempt_id" do
    html ShowPage, attempt: AttemptQuery.find(attempt_id)
  end
end
