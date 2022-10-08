class Items::FormFields < BaseComponent
  needs operation : SaveItem

  def render
    mount Shared::Field, operation.uri, &.text_input(autofocus: "true")
    mount Shared::Field, operation.identifier
  end
end
