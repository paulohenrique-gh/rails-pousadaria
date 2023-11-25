class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  protected

  def render_status_500
    render status: 500, json: { error: 'Erro interno' }
  end

  def render_status_404
    render status: 404, json: { error: 'Não encontrado' }
  end
end
