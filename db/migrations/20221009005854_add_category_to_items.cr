class AddCategoryToItems::V20221009005854 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Item) do
      add category : String?
    end
  end

  def rollback
    alter table_for(Item) do
      remove :category
    end
  end
end
