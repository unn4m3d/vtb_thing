class Items::IndexPage < MainLayout
  needs items : ItemQuery
  quick_def page_title, "All Items"

  def content
    render_template "items/index_page.ecr"
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
