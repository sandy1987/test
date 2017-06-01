class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json
  before_action :authenticate

  def current_user
    User.find_by(authentication_token: request.headers.env['HTTP_AUTH_TOKEN'])
  end

  def fund_to_be_withdraw
    total_fund = current_user.work_schedules.pluck(:amount).sum
    withdrawl_fund = Transaction.all.pluck(:amount).sum
    available_fund = (total_fund - withdrawl_fund)
    return available_fund
  end

  def landing_page_detail_for_loggedin_user
    if current_user.is_admin?
      { incomplete_profile: false, role: 'admin', all_schedules: WorkSchedule.all }
    else
      { incomplete_profile: false, role: 'user', next_schedule: current_user.work_schedules.where("start_date >= ?", Time.now.to_date).first }
    end
  end

  protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      User.find_by(authentication_token: request.headers.env['HTTP_AUTH_TOKEN'])
    end

    def fund_after_tax_deduction gross_pay
      taxes = intereset(gross_pay, 14.3)
      deduction = intereset(gross_pay, 3.5)
      withdrawal = intereset(gross_pay, 10.7)
      { amount: gross_pay, taxes: taxes, deduction: deduction, withdrawal: withdrawal, net_pay: (gross_pay - (taxes+deduction+withdrawal)) }
    end

    def intereset amount, percent
      (amount*percent/100).round(0)
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Bad credentials', status: 401
    end

end
