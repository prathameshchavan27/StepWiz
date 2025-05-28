class FocusSessionsController < ApplicationController
    def new
        @focus_session = FocusSession.new
    end
    def create
        @focus_session = FocusSession.new(focus_session_params)
        @focus_session.user = current_user
        @focus_session.completed_at = Time.current

        if @focus_session.save
            current_user.increment!(:xp, 10)  # 💥 Award XP
            redirect_back fallback_location: roadmap_step_path(@focus_session.roadmap_step_id), notice: "✅ Focus session recorded! +10 XP"
        else
            redirect_to roadmap_step_path(@focus_session.roadmap_step_id), alert: "⚠️ Could not save session."
        end
    end

    private

    def focus_session_params
        params.require(:focus_session).permit(:roadmap_step_id, :duration, :completed_at)
    end
end
