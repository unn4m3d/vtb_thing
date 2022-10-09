class AddStatusToItems::V20221008232443 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Item) do
      add status : Int32, default: 0
    end
  end

  def rollback
    alter table_for(Item) do
      remove :status
    end
  end
end
