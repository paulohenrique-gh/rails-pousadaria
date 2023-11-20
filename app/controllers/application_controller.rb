class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    if current_guest && session["reservation"]
      return room_confirm_path(session["reservation"]["room_id"],
                               params: { reservation: session["reservation"] })
    else
      root_path
    end
  end

  def redirect_new_host_to_guesthouse_creation
    if current_user && current_user.guesthouse.nil?
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

  def set_room(room_id)
    @room = Room.find(room_id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :document])
  end
end
