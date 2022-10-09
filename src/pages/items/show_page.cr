class Items::ShowPage < MainLayout
  needs item : Item
  quick_def page_title, "Item with id: #{item.id}"

  def content
    #link "Back to all Items", Items::Index
    h1 "Item with id: #{item.id}"
    render_actions
    render_item_fields
  end

  def render_actions
    section do
      link "Edit", Items::Edit.with(item.id)
      text " | "
      link "Delete",
        Items::Delete.with(item.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_item_fields
    ul do
      li do
        text "uri: "
        strong item.uri.to_s
      end
      li do
        text "identifier: "
        strong item.identifier.to_s
      end
    end
  end
end
