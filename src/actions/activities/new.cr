class Activities::New < BrowserAction
  get "/activities/new" do
    html NewPage, operation: SaveActivity.new
  end
end
