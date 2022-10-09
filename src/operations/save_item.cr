class SaveItem < Item::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  permit_columns identifier, price, category, token_id, uri
  file_attribute :pic

  needs current_user : User

  before_save do
    if pic.value.nil? && uri.value.nil?
      uri.value = "none"
    end
    pic.value.try do |pv|
      upload_pic pv
    end

    status.value = Item::Status::Active
  end

  before_save check_perms

  def check_perms
    unless current_user.admin
      puts "not an admin"
      identifier.add_error("You're not an admin, man") 
    end
  end

  private def upload_pic(pic)
    result = Shrine.upload(File.new(pic.tempfile.path), "store", metadata: { "filename" => pic.filename })

    # If the new file is uploaded, no reason to keep the old one!
    # If multiple models can share an image, run a query before deleting
    # to ensure you're not breaking any references.
    if old_image = pic_id.original_value
      delete_old_profile_image(old_image)
    end

    pic_id.value = result.id
    if pic_id.value.nil?
      uri.value = "none"
    else
      uri.value = Shrine.find_storage("store").url(pic_id.value.not_nil!)
    end
  end

  private def delete_old_profile_image(old_image)
    storage = Shrine.find_storage("store")
    if storage.exists?(old_image)
      storage.delete(old_image)
    end
  end
end
