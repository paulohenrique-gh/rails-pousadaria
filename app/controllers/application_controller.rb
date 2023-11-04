class ApplicationController < ActionController::Base
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
