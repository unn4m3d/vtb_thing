class CreateActivities::V20221008100139 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Activity) do
      primary_key id : Int64
      add_timestamps
      add title : String
      add next : Time
    end
  end

  def rollback
    drop table_for(Activity)
  end
end
