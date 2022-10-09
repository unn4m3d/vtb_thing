class Items::FormFields < BaseComponent
  needs operation : SaveItem

  def render
    mount Shared::Field, operation.identifier
    mount Shared::Field, operation.price
    mount Shared::Field, operation.category
    mount Shared::Field, operation.pic, &.file_input
    mount Shared::Field, operation.uri
  end
end
