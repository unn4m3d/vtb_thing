class Items::FormFields < BaseComponent
  needs operation : SaveItem

  def render
    mount Shared::Field, operation.identifier
    mount Shared::Field, operation.pic, &.file_input
  end
end
