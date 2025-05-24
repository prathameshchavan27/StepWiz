class Roadmap < ApplicationRecord
  belongs_to :user
  has_many :roadmap_steps, -> { order(:position) }, dependent: :destroy
end
