class Items::Index < BrowserAction
  get "/items" do
    html IndexPage, items: ItemQuery.new
  end
end
