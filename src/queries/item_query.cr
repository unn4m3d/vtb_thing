class ItemQuery < Item::BaseQuery
    def by_cat(cat)
        status(Item::Status::Active).category.nilable_eq(cat)
    end

    def active
        status(Item::Status::Active)
    end
end
