class Activities::NewPage < MainLayout
  needs operation : SaveActivity
  quick_def page_title, "New Activity"

  def content
    h1 "New Activity"
    render_activity_form(operation)
  end

  def render_activity_form(op)
    form_for Activities::Create do
      # Edit fields in src/components/activities/form_fields.cr
      mount Activities::FormFields, op

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
