class SignUpUser < User::SaveOperation
  param_key :user
  # Change password validations in src/operations/mixins/password_validations.cr
  include PasswordValidations

  permit_columns email, bio, message
  attribute password : String
  attribute password_confirmation : String
  file_attribute :profile_pic

  before_save do
    validate_uniqueness_of email
    Authentic.copy_and_encrypt(password, to: encrypted_password) if password.valid?

    wallet = WalletHelper.new
    wallet_privkey.value = wallet.privkey
    wallet_pubkey.value = wallet.pubkey

    profile_pic.value.try do |pic|
      upload_pic pic
    end

    if UserQuery.new.select_count == 0
      admin.value = true
    end
  end

  private def upload_pic(pic)
    result = Shrine.upload(File.new(pic.tempfile.path), "store", metadata: { "filename" => pic.filename })

    # If the new file is uploaded, no reason to keep the old one!
    # If multiple models can share an image, run a query before deleting
    # to ensure you're not breaking any references.
    if old_image = profile_pic_id.original_value
      delete_old_profile_image(old_image)
    end

    profile_pic_id.value = result.id
  end

  private def delete_old_profile_image(old_image)
    storage = Shrine.find_storage("store")
    if storage.exists?(old_image)
      storage.delete(old_image)
    end
  end
end
