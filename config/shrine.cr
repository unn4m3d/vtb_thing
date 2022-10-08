Shrine.configure do |config|
    config.storages["cache"] = Shrine::Storage::FileSystem.new("uploads", prefix: "cache")
    config.storages["store"] = Shrine::Storage::FileSystem.new("uploads")
end