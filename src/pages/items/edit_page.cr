class Items::EditPage < MainLayout
  needs operation : SaveItem
  needs item : Item
  quick_def page_title, "Edit Item with id: #{item.id}"

  def content
    #link "Back to all Items", Items::Index.with("")
    h1 "Edit Item with id: #{item.id}"
    render_item_form(operation)
  end

  def render_item_form(op)
    form_for Items::Update.with(item.id), multipart: true do
      # Edit fields in src/components/items/form_fields.cr
      mount Items::FormFields, op

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
