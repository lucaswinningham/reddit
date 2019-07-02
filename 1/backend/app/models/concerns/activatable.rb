module Activatable
  extend ActiveSupport::Concern
  extend ActiveModel::Callbacks

  included do
    define_model_callbacks :deactivate, only: :before
    before_create :activate
  end

  def deactivate
    run_callbacks :deactivate do
      update active: false
    end
  end

  private

  def activate
    self.active = true
  end
end
