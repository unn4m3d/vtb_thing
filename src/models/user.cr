class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column encrypted_password : String
    column wallet_pubkey : String
    column wallet_privkey : String
    column xp : Int64
    column message : String?
    column bio : String?
    has_many attempts : Attempt
    column profile_pic_id : String?
    column admin : Bool
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end

  def nfts
    wallet = WalletHelper.new wallet_privkey, wallet_pubkey

    ItemQuery.new.uri.in wallet.nft_balance.map &.uri
  end

  def wallet_helper
    WalletHelper.new wallet_privkey, wallet_pubkey
  end

  def pic_url
    if profile_pic_id.nil?
      ""
    else
      Shrine.find_storage("store").url(profile_pic_id.not_nil!)
    end
  end
end
