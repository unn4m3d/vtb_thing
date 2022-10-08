class Activities::Create < BrowserAction
  post "/activities" do
    SaveActivity.create(params) do |operation, activity|
      if activity
        flash.success = "The record has been saved"
        redirect Show.with(activity.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
