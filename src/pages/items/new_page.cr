class Items::NewPage < MainLayout
  needs operation : SaveItem
  quick_def page_title, "New Item"

  def content
    h1 "New Item"
    render_item_form(operation)
  end

  def render_item_form(op)
    form_for Items::Create, multipart:true  do
      # Edit fields in src/components/items/form_fields.cr
      mount Items::FormFields, op

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
