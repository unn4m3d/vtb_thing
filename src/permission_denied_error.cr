class PermissionDeniedError < Exception
    def initialize
        super "Permission Denied"
    end
end