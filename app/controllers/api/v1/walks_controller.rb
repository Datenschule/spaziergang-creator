class API::V1::WalksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
    @walks = Walk.is_public
    render "api/walks/index.json", locals: {status: "success" }
  end

  def show
    @walk = Walk.find(params[:id])

    if @walk.public
      @stations = Station.where(walk_id: @walk.id)

      @stations.map do |station|
        subjects = Subject.where(station_id: station.id)
        station.subjects = subjects
      end

      render "api/walks/show.json", locals: {status: "success"}
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def record_not_found
    render "api/walks/error.json", locals: {status: "error", message: "walk not found"}
  end
end
