class Items::IndexPage < MainLayout
  needs items : ItemQuery
  quick_def page_title, "All Items"

  def content
    h1 "All Items"
    link "New Item", to: Items::New
    render_items
  end

  def render_items
    ul do
      items.each do |item|
        li do
          link item.uri, Items::Show.with(item)
        end
      end
    end
  end
end
