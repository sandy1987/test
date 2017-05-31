class Api::V1::DashboardController < Api::V1::ApiController

  def contact_info;end

  def home
    render json: landing_page_detail_for_loggedin_user.as_json
  end

  def terms_of_aggrement;end

end
