class ReportsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_action :create_report, only: [:create]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  load_and_authorize_resource

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.includes(:categories, :media)
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
    3.times { @report.media.build }
  end

  # GET /reports/1/edit
  def edit
    3.times { @report.media.build }
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user = current_user

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @report }
      else
        format.html { render action: 'new' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    @report.categories.clear

    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end

  def rate
    rate = Rating.find_by(['user_id = ? AND report_id = ?', current_user.id, params[:id]])
    if rate
      rate.rating = params[:report][:rating]
      rate.save
    else
      Rating.create(rating: params[:report][:rating],
                    report_id: params[:id],
                    user_id: current_user.id)
    end

    respond_to do |format|
      if @report.update(report_params)
        format.json { render json: { rating: @report.rating }, status: :ok }
      else
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup
  # or constraints between actions.
  def set_report
    @report = Report.find(params[:id]) unless params[:id].nil?
  end

  def set_categories
    @categories = Category.order(:name)
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def report_params
    params.require(:report)
      .permit(:title, :description, :body, :location, :active, :rating,
              media_attributes: [:id, :label, :file, :_destroy], category_ids: [])
  end

  def create_report
    @report = Report.new(report_params)
  end
end
