class Activities::Index < BrowserAction
  get "/activities" do
    html IndexPage, activities: ActivityQuery.new
  end
end
