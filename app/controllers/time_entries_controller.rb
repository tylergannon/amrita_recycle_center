class TimeEntriesController < ApplicationController
  respond_to :js
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy]

  def index
    @time_entries = TimeEntry.all
    if params[:date]
      @date = Date.parse(params[:date])
      @time_entries.where! start_time: @date..(@date+1.day)
    end
    @time_entry   = TimeEntry.new
    respond_with(@time_entries)
  end

  def show
    respond_with(@time_entry)
  end

  def new
    @time_entry = TimeEntry.new
    respond_with(@time_entry)
  end

  def edit
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.save
    respond_with(@time_entry)
  end

  def update
    @time_entry.update(time_entry_params)
    respond_with(@time_entry)
  end

  def destroy
    @time_entry.destroy
    respond_with(@time_entry)
  end

  private
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    def time_entry_params
      params.require(:time_entry).permit(:start_time, :end_time, :task_id, :reporting_date)
    end
end
