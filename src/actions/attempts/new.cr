class Attempts::New < BrowserAction
  get "/attempts/new" do
    html NewPage, operation: SaveAttempt.new
  end
end
