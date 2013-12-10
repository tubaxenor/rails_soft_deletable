require "soft_deletable_model_callbacks"

class Keeper< ActiveRecord::Base
  soft_deletable

  include SoftDeletableModelCallbacks
end
