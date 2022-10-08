class CreateItems::V20221008100728 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Item) do
      primary_key id : Int64
      add_timestamps
      add uri : String
      add identifier : String
    end
  end

  def rollback
    drop table_for(Item)
  end
end
