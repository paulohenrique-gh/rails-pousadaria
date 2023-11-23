class Api::V1::RoomsController < Api::V1::ApiController
  def index
    guesthouse = Guesthouse.find(params[:guesthouse_id])
    rooms = guesthouse.rooms.where(available: true)

    render status: 200, json: rooms.as_json(except: [:guesthouse_id,
                                                     :created_at, :updated_at])
  end
end
