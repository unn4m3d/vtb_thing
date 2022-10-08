class AddPriceToItems::V20221008135011 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Item) do
      add price : Float64?
    end
  end

  def rollback
    alter table_for(Item) do
      remove :price
    end
  end
end
