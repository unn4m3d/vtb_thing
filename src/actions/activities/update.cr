class Activities::Update < BrowserAction
  put "/activities/:activity_id" do
    activity = ActivityQuery.find(activity_id)
    SaveActivity.update(activity, params) do |operation, updated_activity|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updated_activity.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, activity: updated_activity
      end
    end
  end
end
