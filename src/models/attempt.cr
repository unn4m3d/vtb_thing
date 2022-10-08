class Attempt < BaseModel
  enum Status
    InProgress = 0
    Complete = 1
  end
  
  table do
    belongs_to user : User
    belongs_to activity : Activity

    column status : Attempt::Status
  end
end
