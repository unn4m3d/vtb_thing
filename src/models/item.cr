class Item < BaseModel
  enum Status
    None
    Active
    Locked
  end

  table do
    column uri : String
    column identifier : String
    column pic_id : String?
    column price : Float64?
    column token_id : Int64
    column status : Item::Status
    column category : String?
  end


  def pic_url
    if uri != "none"
      return uri
    end
    if pic_id.nil?
      return ""
    end
    Shrine.find_storage("store").url(pic_id.not_nil!)
  end
end
