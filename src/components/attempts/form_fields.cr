class Attempts::FormFields < BaseComponent
  needs operation : SaveAttempt

  def render
    mount Shared::Field, operation.title, &.text_input(autofocus: "true")
  end
end
