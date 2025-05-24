class StepCompletionsController < ApplicationController
    before_action :set_roadmap_step_and_rodmap, only: %i[ create destroy ]

    def create
        current_user.step_completions.create(roadmap_step: @roadmap_step)
        redirect_to roadmap_path(@roadmap)
    end

    def destroy
        completion = current_user.step_completions.find_by(roadmap_step: @roadmap_step)
        completion.destroy if completion.present?
        redirect_to roadmap_path(@roadmap)
    end

    private
    def set_roadmap_step_and_rodmap
        @roadmap_step = RoadmapStep.find(params[:roadmap_step_id])
        @roadmap = @roadmap_step.roadmap
    end

  # select u.name, rs.title  from users u inner join step_completions sc on u.id=sc.user_id inner join roadmap_steps rs on rs.id = sc.roadmap_step_id;
end
