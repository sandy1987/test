class Api::V1::DashboardController < Api::V1::ApiController

  def contact_info;end

  def home
    landing_page_detail_for_loggedin_user
  end

  def terms_of_aggrement;end

end
