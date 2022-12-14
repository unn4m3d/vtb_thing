class SignUps::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  post "/sign_up" do
    SignUpUser.create(params) do |operation, user|
      if user
        flash.info = "Thanks for signing up"
        sign_in(user)
        redirect to: Home::Index
      else
        operation.errors.each do |x| puts x.to_s end
        flash.info = "Couldn't sign you up"
        html NewPage, operation: operation
      end
    end
  end
end
