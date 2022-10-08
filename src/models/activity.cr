class Activity < BaseModel
  enum Type
    Lottery = 0
    Manual = 1
    Quiz = 2
  end

  table do
    column title : String
    column next_time : Time
    column a_type : Activity::Type
    has_many attempts : Attempt
  end
end
