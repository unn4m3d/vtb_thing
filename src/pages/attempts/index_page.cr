class Attempts::IndexPage < MainLayout
  needs attempts : AttemptQuery
  quick_def page_title, "All Attempts"

  def content
    h1 "All Attempts"
    link "New Attempt", to: Attempts::New
    render_attempts
  end

  def render_attempts
    ul do
      attempts.each do |attempt|
        li do
          link attempt.title, Attempts::Show.with(attempt)
        end
      end
    end
  end
end
