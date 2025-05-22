class RoadmapStep < ApplicationRecord
    belongs_to :roadmap
    before_create :set_position

    private

    def set_position
        if self.position.nil?
            self.position = (roadmap.roadmap_steps.maximum(:position) || 0) + 1
        end
    end
end
