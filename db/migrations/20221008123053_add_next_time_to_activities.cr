class AddNextTimeToActivities::V20221008123053 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Activity) do
      #add next_time : Time?
    end
  end

  def rollback
    alter table_for(Activity) do
      #remove :next_time
    end
  end
end
