class SignIns::NewPage < AuthLayout
  needs operation : SignInUser

  def content
    render_template "sign_ins/new_page.ecr"
  end

  private def render_sign_in_form(op)
    form_for SignIns::Create do
      sign_in_fields(op)
      submit "Sign In", flow_id: "sign-in-button"
    end
    link "Reset password", to: PasswordResetRequests::New
    text " | "
    link "Sign up", to: SignUps::New
  end

  private def sign_in_fields(op)
    mount Shared::Field, attribute: op.email, label_text: "E-mail", &.email_input(autofocus: "true")
    mount Shared::Field, attribute: op.password, label_text: "Пароль", &.password_input
  end
end
