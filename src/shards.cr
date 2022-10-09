# Load .env file before any other config or app code
require "lucky_env"
LuckyEnv.load?(".env")

# Require your shards here
require "lucky"
require "avram/lucky"
require "carbon"
require "authentic"
require "jwt"
require "shrine"
require "kilt"

module Lucky::HTMLBuilder
    macro render_template(template)
        Kilt.embed "src/pages/{{template.id}}", io_name: view
    end
end

module HTML
    def self.escape(x : Nil)
        ""
    end
end