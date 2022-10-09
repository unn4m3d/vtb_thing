class Items::Index < BrowserAction

  get "/items" do #TODO: Remove category
    html IndexPage, items: ItemQuery.new.active
  end
end
