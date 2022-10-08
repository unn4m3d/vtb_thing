class Attempts::ShowPage < MainLayout
  needs attempt : Attempt
  quick_def page_title, "Attempt with id: #{attempt.id}"

  def content
    link "Back to all Attempts", Attempts::Index
    h1 "Attempt with id: #{attempt.id}"
    render_actions
    render_attempt_fields
  end

  def render_actions
    section do
      link "Edit", Attempts::Edit.with(attempt.id)
      text " | "
      link "Delete",
        Attempts::Delete.with(attempt.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_attempt_fields
    ul do
      li do
        text "title: "
        strong attempt.title.to_s
      end
    end
  end
end
