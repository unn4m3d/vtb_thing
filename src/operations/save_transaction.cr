class SaveTransaction < Transaction::SaveOperation
  # To save user provided params to the database, you must permit them
  # https://luckyframework.org/guides/database/saving-records#perma-permitting-columns
  permit_columns title, fromw, tow, content, hash, status, chained_id
end
