class Item < BaseModel
  table do
    column uri : String
    column identifier : String
    column pic_id : String?
  end
end
