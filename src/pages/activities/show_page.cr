class Activities::ShowPage < MainLayout
  needs activity : Activity
  quick_def page_title, "Activity with id: #{activity.id}"

  def content
    link "Back to all Activities", Activities::Index
    h1 "Activity with id: #{activity.id}"
    render_actions
    render_activity_fields
  end

  def render_actions
    section do
      link "Edit", Activities::Edit.with(activity.id)
      text " | "
      link "Delete",
        Activities::Delete.with(activity.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_activity_fields
    ul do
      li do
        text "title: "
        strong activity.title.to_s
      end
      li do
        text "next: "
        strong activity.next_time.to_s
      end
    end
  end
end
