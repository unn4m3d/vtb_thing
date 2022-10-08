class AddAdminFlag::V20221008113033 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add admin : Bool, default: false
    end
  end

  def rollback
    alter table_for(User) do
      remove :admin
    end
  end
end
