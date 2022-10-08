class Activities::Edit < BrowserAction
  get "/activities/:activity_id/edit" do
    activity = ActivityQuery.find(activity_id)
    html EditPage,
      operation: SaveActivity.new(activity),
      activity: activity
  end
end
