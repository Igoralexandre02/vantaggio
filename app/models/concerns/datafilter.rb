module Datafilter
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
  end
end
