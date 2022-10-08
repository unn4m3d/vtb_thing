class Items::IndexPage < MainLayout
  needs items : ItemQuery
  quick_def page_title, "All Items"

  def content
    h1 "All Items"
    if current_user.admin
      link "New Item", to: Items::New
    end
    render_items
  end

  def render_items
    ul do
      items.each do |item|
        li do
          link item.identifier, to: Items::Buy.with(item)
        end
      end
    end
  end
end
