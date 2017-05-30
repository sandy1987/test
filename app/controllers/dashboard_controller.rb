class DashboardController < ApplicationController

  def contact_info;end

  def home
    redirect_to landing_page_for_loggedin_user
  end

  def terms_of_aggrement;end

  private

    def landing_page_for_loggedin_user
      if current_user.is_admin?
        work_schedules_path
      else
        next_schedule_path
      end
    end

end
