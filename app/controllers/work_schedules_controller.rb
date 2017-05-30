class WorkSchedulesController < ApplicationController
  before_action :set_work_schedule, only: [:show, :edit, :update, :destroy]
  before_action :check_user_execess, except: [:show, :next_schedule, :my_schedule]

  def create
    @work_schedule = WorkSchedule.new(work_schedule_params)

    if @work_schedule.save
      redirect_to @work_schedule, notice: 'Work schedule was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @work_schedule.destroy
    redirect_to work_schedules_url, notice: 'Work schedule was successfully destroyed.'
  end

  def edit
  end

  def index
    @work_schedules = WorkSchedule.all
  end

  def my_schedule
    if current_user.is_admin?
      @work_schedules = WorkSchedule.all
      @my_schedule = WorkSchedule.where(id:params[:schedule_id]).first if params[:schedule_id].present?
    else
      @work_schedules = current_user.work_schedules.all
      @my_schedule = current_user.work_schedules.where(id:params[:schedule_id]).first if params[:schedule_id].present?
    end
  end

  def new
    @work_schedule = WorkSchedule.new
  end

  def next_schedule
    @next_schedule = current_user.work_schedules.order('start_date ASC').first
  end

  def show
  end

  def update
    if @work_schedule.update(work_schedule_params)
      redirect_to @work_schedule, notice: 'Work schedule was successfully updated.'
    else
      render :edit
    end
  end

  private

    def check_user_execess
      redirect_to root_path, notice: 'You are not authorised to visit this page!' unless current_user.has_role? :admin
    end

    def same_format date
      date.to_date.strftime("%m/%d/%Y")      
    end

    def set_work_schedule
      @work_schedule = WorkSchedule.find(params[:id])
    end

    def work_schedule_params
      params.require(:work_schedule).permit(:start_date, :location, :role, :shift_type, :time_slot_1, :time_slot_2, :total_hours, :amount, :user_id)
    end
end
