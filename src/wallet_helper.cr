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

        @[JSON::Field(key: "URI")]
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
end