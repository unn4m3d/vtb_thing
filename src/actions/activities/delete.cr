class Activities::Delete < BrowserAction
  delete "/activities/:activity_id" do
    activity = ActivityQuery.find(activity_id)
    DeleteActivity.delete(activity) do |_operation, _deleted|
      flash.success = "Deleted the activity"
      redirect Index
    end
  end
end
