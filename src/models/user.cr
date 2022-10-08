class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column encrypted_password : String
    column wallet_pubkey : String
    column wallet_privkey : String
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
