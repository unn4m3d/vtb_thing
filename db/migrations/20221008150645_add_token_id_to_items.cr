class AddTokenIdToItems::V20221008150645 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Item) do
      add token_id : Int64, default: 0i64
    end
  end

  def rollback
    alter table_for(Item) do
      remove :token_id
    end
  end
end
