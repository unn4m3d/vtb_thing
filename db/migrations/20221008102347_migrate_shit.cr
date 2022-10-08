class MigrateShit::V20221008102347 < Avram::Migrator::Migration::V1
  def migrate
    # Read more on migrations
    # https://www.luckyframework.org/guides/database/migrations
    #
    # create table_for(Thing) do
    #   primary_key id : Int64
    #   add_timestamps
    #
    #   add title : String
    #   add description : String?
    # end

    # Run custom SQL with execute
    #
    # execute "CREATE UNIQUE INDEX things_title_index ON things (title);"

    alter table_for(User) do
      add xp : Int64, default: 0i64
      add message : String?
      add bio : String?
    end

    alter table_for(Attempt) do
      add_belongs_to user : User, on_delete: :cascade
      add_belongs_to activity : Activity, on_delete: :cascade
      add status : Int32, default: Attempt::Status::InProgress.to_i32
    end

    alter table_for(Activity) do
      add a_type : Int32, default: Activity::Type::Lottery.to_i32
    end
  end

  def rollback
    alter table_for(User) do
      remove :xp
      remove :message
      remove :bio
    end

    alter table_for(Attempt) do
      remove_belongs_to :user
      remove_belongs_to :activity
      remove :status
    end

    alter table_for(Activity) do
      remove :a_type
    end
  end
end
