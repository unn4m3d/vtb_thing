class MakeActivityNextTimeOptional::V20221009074716 < Avram::Migrator::Migration::V1
  def migrate
    make_optional table_for(Activity), :next_time
  end

  def rollback
     make_required table_for(Activity), :next_time
  end
end
