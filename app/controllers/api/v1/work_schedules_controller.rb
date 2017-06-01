class Api::V1::WorkSchedulesController < Api::V1::ApiController

  def my_schedule
    date = params['work_schedule']['start_date'].try(:to_date)
    my_schedules =  if (request.method == "POST") && date.present?
                      current_user.work_schedules.where("start_date >=?",date)
                    else
                      current_user.work_schedules
                    end
    render json: { my_schedules: my_schedules }
  end

  def next_schedule
    render json: { next_schedule: current_user.work_schedules.where("start_date >= ?", Time.now.to_date).first, available_fund: fund_to_be_withdraw }
  end

end
