class Api::V1::RoomsController < Api::V1::ApiController
  def index
    guesthouse = Guesthouse.find(params[:guesthouse_id])
    rooms = guesthouse.rooms.where(available: true)

    render status: 200, json: rooms.as_json(except: [:guesthouse_id,
                                                     :created_at, :updated_at])
  end

  def check_availability
    @room = Room.find(params[:room_id])
    return render status: 400 if bad_request?

    checkin = params[:checkin].to_date
    checkout = params[:checkout].to_date
    guest_count = params[:guest_count]
    response_hash = {}

    if !@room.booked?(checkin, checkout) && @room.available
      response_hash["stay_total"] = @room.reservations.build
                                         .calculate_stay_total(checkin, checkout)
    else
      response_hash["error"] = 'Quarto não disponível'
    end

    render status: 200, json: response_hash
  end

  private

  def bad_request?
    date_format = Regexp.new('^[0-3][0-9]-[0-1][0-9]-20[2-9][0-9]$')

    params[:checkin].nil? || params[:checkout].nil? || params[:guest_count].nil? ||
    !params[:checkin].match?(date_format) || !params[:checkout].match?(date_format) ||
    params[:guest_count].to_i > @room.max_people || params[:guest_count].to_i <= 0
  end
end
