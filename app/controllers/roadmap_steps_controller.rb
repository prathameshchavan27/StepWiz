class RoadmapStepsController < ApplicationController
    before_action :set_roadmap_step, only: %i[ show edit update destroy ]
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

    private
    def set_roadmap_step
        @roadmap_step = RoadmapStep.find(params[:id])
    end

    def roadmap_step_params
        params.require(:roadmap_step).permit(:title,:description,:resource_link,:position,:dependency_step_id)
    end
end
