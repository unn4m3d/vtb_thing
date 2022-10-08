class Items::New < BrowserAction
  get "/items/new" do
    unless current_user.admin
      raise PermissionDeniedError.new
    end
    html NewPage, operation: SaveItem.new(current_user: current_user)
  end
end
