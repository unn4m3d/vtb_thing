class CreateTransactions::V20221008143747 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Transaction) do
      primary_key id : Int64
      add_timestamps
      add title : String
      add fromw : String
      add tow : String
      add content : String
      add status : Int32, default: WalletHelper::TransactionStatus::Deferred.to_i32
      add hash : String
      add_belongs_to chained : Transaction?, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Transaction)
  end
end
