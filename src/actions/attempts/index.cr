class Attempts::Index < BrowserAction
  get "/attempts" do
    html IndexPage, attempts: AttemptQuery.new
  end
end
