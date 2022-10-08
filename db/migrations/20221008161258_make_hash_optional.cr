class MakeHashOptional::V20221008161258 < Avram::Migrator::Migration::V1
  def migrate
    make_optional table_for(Transaction), :hash
  end

  def rollback
    make_required table_for(Transaction), :hash
  end
end
