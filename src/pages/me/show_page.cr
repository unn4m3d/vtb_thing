class Me::ShowPage < MainLayout
  needs transactions : TransactionQuery

  def content
    # h1 "This is your profile"
    # h3 "Email:  #{@current_user.email}"

    # wallet = WalletHelper.new @current_user.wallet_privkey, @current_user.wallet_pubkey



    # h3 "Balance: "
    # wallet.balance.each do |k,v|
    #   para "#{k}: #{v}"
    # end
    # para "Pubkey: #{@current_user.wallet_pubkey}"
    # helpful_tips
    
    render_template "me/show_page.ecr"
  end

  private def badge_class(s)
    case s
    when .success?
        "badge bg-success"
    when .pending?
        "badge bg-secondary"
    else
        "badge bg-danger"
    end
  end

  private def helpful_tips
    h3 "Next, you may want to:"
    ul do
      li { link_to_authentication_guides }
      li "Modify this page: src/pages/me/show_page.cr"
      li "Change where you go after sign in: src/actions/home/index.cr"
    end
  end

  private def link_to_authentication_guides
    a "Check out the authentication guides",
      href: "https://luckyframework.org/guides/authentication"
  end
end
