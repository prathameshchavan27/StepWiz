class RoadmapStepsController < ApplicationController
    before_action :set_roadmap_step, only: %i[ show edit update destroy move_up move_down]
    def index
    end

    def new
        @roadmap = Roadmap.find(params[:roadmap_id])
        @roadmap_step = @roadmap.roadmap_steps.build
    end

    def create
        @roadmap = Roadmap.find(params[:roadmap_step][:roadmap_id])
        @roadmap_step = @roadmap.roadmap_steps.build(roadmap_step_params)
        @roadmap_step.dependency_step_id = @roadmap.roadmap_steps.order(:position).to_a[-1]&.id
        if @roadmap_step.save
            redirect_to @roadmap
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @user_sessions_count = current_user.focus_sessions.where(roadmap_step: @roadmap_step).count
    end

    def edit
    end

    def update
        if @roadmap_step.update(roadmap_step_params)
            redirect_to @roadmap_step
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @roadmap = @roadmap_step.roadmap
        @roadmap_step.destroy
        redirect_to roadmap_path(@roadmap)
    end

    def move_up
        sibling = RoadmapStep.find_by(position: @roadmap_step.position - 1, roadmap_id: @roadmap_step.roadmap_id)

        unless sibling
            redirect_back fallback_location: roadmap_path(@roadmap_step.roadmap), alert: "Already at the top!"
            return
        end

        RoadmapStep.transaction do
            # Temporarily set current step to an unused position to avoid collision
            @roadmap_step.update!(position: -1)

            # Move sibling down
            sibling.update!(position: sibling.position + 1)

            # Move current step up
            @roadmap_step.update!(position: sibling.position - 1)
        end

        redirect_back fallback_location: roadmap_path(@roadmap_step.roadmap), notice: "Step moved up!"
    end

    def move_down
        sibling = RoadmapStep.find_by(position: @roadmap_step.position + 1, roadmap_id: @roadmap_step.roadmap_id)

        unless sibling
            redirect_back fallback_location: roadmap_path(@roadmap_step.roadmap), alert: "Already at the bottom!"
            return
        end

        RoadmapStep.transaction do
            @roadmap_step.update!(position: -1)
            sibling.update!(position: sibling.position - 1)
            @roadmap_step.update!(position: sibling.position + 1)
        end

        redirect_back fallback_location: roadmap_path(@roadmap_step.roadmap), notice: "Step moved down!"
    end

    private
    def set_roadmap_step
        @roadmap_step = RoadmapStep.find(params[:id])
    end

    def roadmap_step_params
        params.require(:roadmap_step).permit(
            :title, :description, :position, :roadmap_id, :dependency_step_id,
            step_resources_attributes: [ :id, :url, :_destroy ]
        )
    end
end
