class Item < BaseModel
  table do
    column uri : String
    column identifier : String
    column pic_id : String?
    column price : Float64?
  end
end
