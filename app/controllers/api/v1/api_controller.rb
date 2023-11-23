class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :render_status_500

  protected

  def render_status_500
    render status: 500
  end
end
