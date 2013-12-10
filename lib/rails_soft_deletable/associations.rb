require "active_support/concern"
require "rails_soft_deletable/associations/many"
require "rails_soft_deletable/associations/one"

module RailsSoftDeletable
  module Associations
    extend ActiveSupport::Concern

    included do
      class << self
        alias_method_chain :belongs_to, :deleted
        alias_method_chain :has_many, :deleted
        alias_method_chain :has_one, :deleted
      end
    end

    module ClassMethods
      def belongs_to_with_deleted(target, options = {})
        with_deleted = options.delete(:with_deleted)
        result = belongs_to_without_deleted(target, options)

        with_deleted ? One.new(self, target, result).build : result
      end

      def has_one_with_deleted(target, options = {})
        with_deleted = options.delete(:with_deleted)
        result = has_one_without_deleted(target, options)

        with_deleted ? One.new(self, target, result).build : result
      end

      def has_many_with_deleted(target, options = {})
        with_deleted = options.delete(:with_deleted)
        result = has_many_without_deleted(target, options)

        with_deleted ? Many.new(self, target, result).build : result
      end
    end
  end
end
