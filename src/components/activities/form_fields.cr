class Activities::FormFields < BaseComponent
  needs operation : SaveActivity

  def render
    mount Shared::Field, operation.title, &.text_input(autofocus: "true")
    mount Shared::Field, operation.next_time
  end
end
