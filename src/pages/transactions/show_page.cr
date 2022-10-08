class Transactions::ShowPage < MainLayout
  needs transaction : Transaction
  quick_def page_title, "Transaction with id: #{transaction.id}"

  def content
    link "Back to all Transactions", Transactions::Index
    h1 "Transaction with id: #{transaction.id}"
    render_actions
    render_transaction_fields
  end

  def render_actions
    section do
      link "Edit", Transactions::Edit.with(transaction.id)
      text " | "
      link "Delete",
        Transactions::Delete.with(transaction.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_transaction_fields
    ul do
      li do
        text "title: "
        strong transaction.title.to_s
      end
      li do
        text "from: "
        strong transaction.fromw.to_s
      end
      li do
        text "to: "
        strong transaction.tow.to_s
      end
      li do
        text "content: "
        strong transaction.content.to_s
      end
    end
  end
end
