class FocusSession < ApplicationRecord
  belongs_to :user
  belongs_to :roadmap_step
end
