class Transactions::IndexPage < MainLayout
  needs transactions : TransactionQuery
  quick_def page_title, "All Transactions"

  def content
    h1 "All Transactions"
    link "New Transaction", to: Transactions::New
    render_transactions
  end

  def render_transactions
    ul do
      transactions.each do |transaction|
        li do
          link transaction.title, Transactions::Show.with(transaction)
        end
      end
    end
  end
end
