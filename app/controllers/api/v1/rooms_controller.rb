class Api::V1::RoomsController < Api::V1::ApiController
  def index
    guesthouse = Guesthouse.find(params[:guesthouse_id])
    rooms = guesthouse.rooms.where(available: true)

    render status: 200, json: rooms.as_json(except: [:guesthouse_id,
                                                     :created_at, :updated_at])
  end

  def check_availability
    room = Room.find(params[:room_id])
    checkin = params[:checkin]
    checkout = params[:checkout]
    guest_count = params[:guest_count]

    if !room.booked?(checkin, checkout)
      stay_total = room.reservations.build.calculate_stay_total(checkin, checkout)
    else

    end

    render status: 200, json: { stay_total: stay_total }
  end
end
