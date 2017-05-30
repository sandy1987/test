class Api::V1::WorkSchedulesController < Api::V1::ApiController
  before_action :set_work_schedule, only: [:show, :edit, :update, :destroy]
  before_action :check_user_execess, except: [:show, :next_schedule, :my_schedule]

  def create
    @work_schedule = WorkSchedule.new(work_schedule_params)

    if @work_schedule.save
      render :json=> @work_schedule.as_json( notice: 'Work schedule was successfully created.')
    else
      render :new
    end
  end

  def destroy
    @work_schedule.destroy
    render :json=> { notice: 'Successfully destroyed.' }
  end

  def edit;end

  def index
    render :json=> WorkSchedule.all.as_json
  end

  def my_schedule
    if current_user.is_admin?
      @work_schedules = WorkSchedule.all
      @my_schedule = WorkSchedule.where(id:params[:schedule_id]).first if params[:schedule_id].present?
    else
      @work_schedules = current_user.work_schedules.all
      @my_schedule = current_user.work_schedules.where(id:params[:schedule_id]).first if params[:schedule_id].present?
    end
    render :json=> { work_schedules: @work_schedules, my_schedule: @my_schedule }
  end

  def new
    @work_schedule = WorkSchedule.new
  end

  def next_schedule
    render json: current_user.work_schedules.where("start_date >= ?", Time.now.to_date).first
  end

  def show;end

  def update
    if @work_schedule.update(work_schedule_params)
      render :json=> @work_schedule.as_json(msg: 'Work schedule was successfully updated.')
    else
      render :edit
    end
  end

  private

    def check_user_execess
      render :json=> { data: landing_page_detail_for_loggedin_user, msg: 'You are not authorised to visit this page!' } unless current_user.is_admin?
    end

    def set_work_schedule
      @work_schedule = WorkSchedule.find(params[:id])
    end

    def work_schedule_params
      params.require(:work_schedule).permit(:start_date, :location, :role, :shift_type, :time_slot_1, :time_slot_2, :total_hours, :amount, :user_id)
    end

end
