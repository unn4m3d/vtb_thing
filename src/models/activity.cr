class Activity < BaseModel
  table do
    column title : String
    column next_time : Time
  end
end
