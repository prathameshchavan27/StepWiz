class RoadmapStep < ApplicationRecord
    belongs_to :roadmap
    before_create :set_position
    has_many :step_completions
    has_many :completing_users, through: :step_completions, source: :user
    has_many :focus_sessions
    private

    def set_position
        if self.position.nil?
            self.position = (roadmap.roadmap_steps.maximum(:position) || 0) + 1
        end
    end
end
