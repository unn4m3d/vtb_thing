class Attempts::EditPage < MainLayout
  needs operation : SaveAttempt
  needs attempt : Attempt
  quick_def page_title, "Edit Attempt with id: #{attempt.id}"

  def content
    link "Back to all Attempts", Attempts::Index
    h1 "Edit Attempt with id: #{attempt.id}"
    render_attempt_form(operation)
  end

  def render_attempt_form(op)
    form_for Attempts::Update.with(attempt.id) do
      # Edit fields in src/components/attempts/form_fields.cr
      mount Attempts::FormFields, op

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
