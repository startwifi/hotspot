class Admin::Scheduler::EventsController < ApplicationController
  before_action :set_admin_scheduler_event, only: [:show, :edit, :update, :destroy]

  # GET /admin/scheduler/events
  # GET /admin/scheduler/events.json
  def index
    @admin_scheduler_events = Admin::Scheduler::Event.all
  end

  # GET /admin/scheduler/events/1
  # GET /admin/scheduler/events/1.json
  def show
  end

  # GET /admin/scheduler/events/new
  def new
    @admin_scheduler_event = Admin::Scheduler::Event.new
  end

  # GET /admin/scheduler/events/1/edit
  def edit
  end

  # POST /admin/scheduler/events
  # POST /admin/scheduler/events.json
  def create
    @admin_scheduler_event = Admin::Scheduler::Event.new(admin_scheduler_event_params)

    respond_to do |format|
      if @admin_scheduler_event.save
        format.html { redirect_to @admin_scheduler_event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @admin_scheduler_event }
      else
        format.html { render :new }
        format.json { render json: @admin_scheduler_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/scheduler/events/1
  # PATCH/PUT /admin/scheduler/events/1.json
  def update
    respond_to do |format|
      if @admin_scheduler_event.update(admin_scheduler_event_params)
        format.html { redirect_to @admin_scheduler_event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_scheduler_event }
      else
        format.html { render :edit }
        format.json { render json: @admin_scheduler_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/scheduler/events/1
  # DELETE /admin/scheduler/events/1.json
  def destroy
    @admin_scheduler_event.destroy
    respond_to do |format|
      format.html { redirect_to admin_scheduler_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_scheduler_event
      @admin_scheduler_event = Admin::Scheduler::Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_scheduler_event_params
      params[:admin_scheduler_event]
    end
end
