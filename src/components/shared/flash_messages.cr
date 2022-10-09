class Shared::FlashMessages < BaseComponent
  needs flash : Lucky::FlashStore

  def render
    flash.each do |flash_type, flash_message|
      div class: flash_class(flash_type), flow_id: "flash", role: "alert" do
        text flash_message
        button type:"button", class:"btn-close", "data-bs-dismiss": "alert", "aria-label": "Close"
      end
    end
  end

  private def flash_class(flash_type)
    case flash_type
    when "failure"
      "alert alert-danger"
    when "success"
      "alert alert-success"
    else
      "alert alert-primary"
    end + " alert-dismissible fade show"
  end
end
