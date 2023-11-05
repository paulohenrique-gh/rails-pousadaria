class ApplicationController < ActionController::Base
  protected

  def redirect_host_to_guesthouse_creation
    if current_user && current_user.host? && current_user.guesthouse.nil?
      redirect_to(new_guesthouse_path)
    end
  end

  def set_guesthouse_and_check_user(guesthouse_id)
    @guesthouse = Guesthouse.find(guesthouse_id)
    if @guesthouse.user != current_user || @guesthouse.inactive?
      redirect_to(
        root_path,
        alert: 'Você não tem autorização para alterar esta pousada'
      )
    end
  end
end
