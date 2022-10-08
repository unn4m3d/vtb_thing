class Activities::IndexPage < MainLayout
  needs activities : ActivityQuery
  quick_def page_title, "All Activities"

  def content
    h1 "All Activities"
    link "New Activity", to: Activities::New
    render_activities
  end

  def render_activities
    ul do
      activities.each do |activity|
        li do
          link activity.title, Activities::Show.with(activity)
        end
      end
    end
  end
end
