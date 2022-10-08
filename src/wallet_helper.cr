require "json"
require "http/client"

class WalletHelper
    property privkey : String, pubkey : String

    BASE_ADDR = "https://hackathon.lsp.team/hk"

    private def post(method : String, params : String?)
        unless params.nil?
            params = "\n#{params}"
        end

        uri = "#{BASE_ADDR}/#{method}"
        response = HTTP::Client.post(uri, headers: HTTP::Headers{"User-Agent" => "AwesomeApp", "Content-Type"=> "application/json"}, body: params)

        if response.success?
            puts response.body
            response.body
        else
            puts "#{BASE_ADDR}/#{method}"
            puts params
            raise "#{response.status.to_s} : #{response.body}"
        end
    end

    private def get(method : String)
        response = HTTP::Client.get("#{BASE_ADDR}/#{method}")

        if response.success?
            puts response.body
            response.body
        else
            raise "#{response.status.to_s} : #{response.body}"
        end
    end

    private def post(method, params, t : T.class) : T forall T
        T.from_json post(method, params.to_json)
    end

    private def post(method, params : Nil, t : T.class) : T forall T
        T.from_json post(method, nil)
    end

    private def get(method, t : T.class) forall T
        T.from_json get(method)
    end

    class KeyPair
        include JSON::Serializable

        @[JSON::Field(key: "privateKey")]
        property privkey : String

        @[JSON::Field(key: "publicKey")]
        property pubkey : String
    end

    class NFTBalanceEntry
        include JSON::Serializable

        property uri : String

        property tokens : Array(Int64)
    end

    alias Balance = Hash(String, Float64)

    class NFTBalance
        include JSON::Serializable

        property balance : Array(NFTBalanceEntry)
    end

    class TransactionHash
        include JSON::Serializable

        property transaction_hash : String
    end

    class TransactionHash2
        include JSON::Serializable

        @[JSON::Field(key: "transaction")]
        property transaction_hash : String
    end

    def initialize(@privkey, @pubkey)
    end

    def initialize
        keypair = post("v1/wallets/new", nil, KeyPair)

        @privkey = keypair.privkey
        @pubkey = keypair.pubkey
    end

    def balance
        get("v1/wallets/#{@pubkey}/balance", Balance)
    end

    def nft_balance
        get("v1/wallets/#{@pubkey}/nft/balance", NFTBalance).balance
    end

    def gen_collection(uri, count)
        post("v1/nft/generate", {toPublicKey: @pubkey, uri: uri, nftCount: count}, TransactionHash).transaction_hash
    end

    class TransactionStatusImpl
        include JSON::Serializable

        property status : String
    end

    enum TransactionStatus
        Deferred
        Pending
        Success
        Failure
    end

    def status(thash : String)
        case get("v1/transfers/status/#{thash}/", TransactionStatusImpl).status
        when "Success"
            TransactionStatus::Success
        when "Pending"
            TransactionStatus::Pending
        else
            TransactionStatus::Failure
        end
    rescue
        TransactionStatus::Failure
    end

    def transfer_nft(from, to, id)
        post("v1/transfers/nft", {fromPrivateKey: from, toPublicKey: to, tokenId: id}, TransactionHash).transaction_hash
    end

    def transfer_rub(from, to, count)
        post("v1/transfers/ruble", {fromPrivateKey: from, toPublicKey: to, amount: count}, TransactionHash2).transaction_hash
    end
end

spawn do
    loop do
        sleep 60

        puts "Aw fuck me"

        TransactionQuery.new.status(WalletHelper::TransactionStatus::Pending).each do |transaction|
            new_status = transaction.transaction_status

            unless new_status.pending?
                SaveTransaction.update(transaction, status: new_status) do |op, _|
                    if op.saved?
                        transaction.success_hook
                    else
                        puts "man..."
                    end
                end
            end
        end

        nft_balance = WALLET.nft_balance

        ItemQuery.new.token_id(0).each do |item|
            token = nft_balance.select(&.uri.==(item.uri)).first?

            unless token.nil?
                SaveItem.update(item, current_user: UserQuery.find(1), token_id: token.tokens.first) do |_, _|

                end
            end
        end
    end
end