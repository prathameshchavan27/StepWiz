class RoadmapsController < ApplicationController
    before_action :authenticate_user!, only: %i[ new create edit update destroy copy ]
    before_action :set_roadmap, only: %i[ show edit update destroy]

    def index
        @roadmaps = Roadmap.all
    end

    def show
        total_steps = @roadmap.roadmap_steps.count
        completed_steps = 0
        if current_user
            completed_steps = current_user.step_completions.count
            puts completed_steps
        end
        @progress = ((completed_steps.to_f/total_steps)*100).round
    end

    def new
        @roadmap = Roadmap.new
    end

    def create
        @roadmap = Roadmap.new(roadmap_params)
        @roadmap.user = current_user
        if @roadmap.save
            flash[:notice] = "Raodmap created successfully"
            redirect_to @roadmap
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @roadmap.update(roadmap_params)
            flash[:notice] = "Roadmap Updated Succesfully"
            redirect_to roadmaps_path
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @roadmap.destroy
        redirect_to roadmaps_path
    end

    def copy
        original = Roadmap.find(params[:id])
        copy = original.dup
        copy.user = current_user
        copy.title += " (Copy)"
        copy.public = false

        if copy.save
            # Copy steps
            original.roadmap_steps.each do |step|
            copy.roadmap_steps.create(
                title: step.title,
                description: step.description,
                resource_link: step.resource_link,
                position: step.position
            )
            end

            redirect_to roadmap_path(copy), notice: "✅ Roadmap copied successfully!"
        else
            redirect_back fallback_location: roadmaps_path, alert: "❌ Could not copy roadmap."
        end
    end


    private

    def roadmap_params
        params.require(:roadmap).permit(:title, :description, :public)
    end

    def set_roadmap
        @roadmap = Roadmap.find(params[:id])
    end
end
