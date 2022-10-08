class SaveItem < Item::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  permit_columns identifier
  file_attribute :pic

  before_save do
    pic.value.try do |pv|
      upload_pic pv
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
  end

  private def delete_old_profile_image(old_image)
    storage = Shrine.find_storage("store")
    if storage.exists?(old_image)
      storage.delete(old_image)
    end
  end
end
