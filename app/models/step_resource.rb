class StepResource < ApplicationRecord
  belongs_to :roadmap_step
  validates :url, presence: true, format: URI::regexp(%w[http https])
end
