class Attempts::NewPage < MainLayout
  needs operation : SaveAttempt
  quick_def page_title, "New Attempt"

  def content
    h1 "New Attempt"
    render_attempt_form(operation)
  end

  def render_attempt_form(op)
    form_for Attempts::Create do
      # Edit fields in src/components/attempts/form_fields.cr
      mount Attempts::FormFields, op

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
