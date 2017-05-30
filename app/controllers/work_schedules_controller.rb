class WorkSchedulesController < ApplicationController
  before_action :set_work_schedule, only: [:show, :edit, :update, :destroy]
  before_action :check_user_execess, except: [:show, :next_schedule, :my_schedule]

  def create
    @work_schedule = WorkSchedule.new(work_schedule_params)

    respond_to do |format|
      if @work_schedule.save
        format.html { redirect_to @work_schedule, notice: 'Work schedule was successfully created.' }
        format.json { render :show, status: :created, location: @work_schedule }
      else
        format.html { render :new }
        format.json { render json: @work_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work_schedule.destroy
    respond_to do |format|
      format.html { redirect_to work_schedules_url, notice: 'Work schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
  end

  def index
    @work_schedules = WorkSchedule.all
  end

  def my_schedule
     
  end

  def new
    @work_schedule = WorkSchedule.new
  end

  def next_schedule
    @next_schedule = current_user.work_schedules.order('date ASC').first
  end

  def show
  end

  def update
    respond_to do |format|
      if @work_schedule.update(work_schedule_params)
        format.html { redirect_to @work_schedule, notice: 'Work schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_schedule }
      else
        format.html { render :edit }
        format.json { render json: @work_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def check_user_execess
      redirect_to root_path, notice: 'You are not authorised to visit this page!' unless current_user.has_role? :admin
    end

    def set_work_schedule
      @work_schedule = WorkSchedule.find(params[:id])
    end

    def work_schedule_params
      params.require(:work_schedule).permit(:date, :location, :role, :shift_type, :time_slot_1, :time_slot_2, :total_hours, :amount, :user_id)
    end
end
