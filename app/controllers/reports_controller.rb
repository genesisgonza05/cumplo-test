class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    sbif_gateway
    if @sbif.ranges_valid?(sbif_params)
      @sbif.range_by(sbif_params[:start_date], sbif_params[:end_date])
      @dollars_report = @sbif.dollars_report
      @ufs_report = @sbif.uf_report
      data_obtained
    else
      flash[:danger] = @sbif.message_errors
    end
    render :show
  end

  def show
  end

  private

  def data_obtained
    @average_dollar = @sbif.average(@dollars_report)
    @average_uf = @sbif.average(@ufs_report)
    @minmax_dollar = @sbif.minmax_value(@dollars_report)
    @minmax_uf = @sbif.minmax_value(@ufs_report)
  end

  def sbif_params
    params.permit(:start_date, :end_date)
  end

  def sbif_gateway
    @sbif = ManagerSBIF.new  
  end

end
