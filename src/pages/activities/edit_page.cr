class Activities::EditPage < MainLayout
  needs operation : SaveActivity
  needs activity : Activity
  quick_def page_title, "Edit Activity with id: #{activity.id}"

  def content
    link "Back to all Activities", Activities::Index
    h1 "Edit Activity with id: #{activity.id}"
    render_activity_form(operation)
  end

  def render_activity_form(op)
    form_for Activities::Update.with(activity.id) do
      # Edit fields in src/components/activities/form_fields.cr
      mount Activities::FormFields, op

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
