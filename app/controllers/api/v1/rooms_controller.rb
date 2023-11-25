class Api::V1::RoomsController < Api::V1::ApiController
  def index
    guesthouse = Guesthouse.find(params[:guesthouse_id])
    rooms = guesthouse.rooms.where(available: true)

    render status: 200, json: rooms.as_json(except: [:created_at, :updated_at])
  end

  def check_availability
    @room = Room.find(params[:room_id])
    return render status: 400, json: { error: 'Parâmetros inválidos' } if bad_request?

    response_hash = {}

    if !@room.booked?(@checkin, @checkout) && @room.available
      response_hash["stay_total"] = @stay_total
    else
      response_hash["error"] = 'Quarto não disponível'
    end

    render status: 200, json: response_hash
  end

  private

  def bad_request?
    begin
      date_format = Regexp.new('^20[2-9][0-9]-[0-1][0-9]-[0-3][0-9]$')

      @checkin = params[:checkin]
      @checkout = params[:checkout]

      unless @checkin.match?(date_format) && @checkout.match?(date_format)
        return true
      end

      @checkin = @checkin.to_date
      @checkout = @checkout.to_date
      @stay_total = @room.reservations.build
                         .calculate_stay_total(@checkin, @checkout)
      guest_count = params[:guest_count]

      reservation = @room.reservations.build(checkin: @checkin,
                                              checkout: @checkout,
                                              stay_total: @stay_total,
                                              guest_count: guest_count)

      unless reservation.valid?
        return true
      end
    rescue Date::Error
      return true
    end

    return false
  end
end
