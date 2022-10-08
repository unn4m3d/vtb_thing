class Activities::Show < BrowserAction
  get "/activities/:activity_id" do
    html ShowPage, activity: ActivityQuery.find(activity_id)
  end
end
