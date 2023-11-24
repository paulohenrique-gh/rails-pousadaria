class Api::V1::GuesthousesController < Api::V1::ApiController
  def index
    guesthouses = Guesthouse.active
    if params[:search].present?
      guesthouses = guesthouses.where('brand_name LIKE ?', "%#{params[:search]}%")
    end

    guesthouses = guesthouses.as_json.map { |g| guesthouse_json_formatter(g) }

    render status: 200, json: guesthouses
  end

  def show
    guesthouse = Guesthouse.find(params[:id])
    return render status: 404 if guesthouse.inactive?
    average_rating = guesthouse.reviews.average(:rating).to_f
    average_rating = '' if average_rating == 0
    guesthouse = guesthouse_json_formatter(guesthouse.as_json)
    guesthouse["average_rating"] = average_rating

    render status: 200, json: guesthouse
  end

  private

  def guesthouse_json_formatter(guesthouse)
    address = Address.find(guesthouse["address_id"])
                     .as_json(except: [:id, :created_at, :updated_at])
    guesthouse["address"] = address
    guesthouse["checkin_time"] = guesthouse["checkin_time"].to_time.strftime('%H:%M')
    guesthouse["checkout_time"] = guesthouse["checkout_time"].to_time.strftime('%H:%M')
    guesthouse.except!("corporate_name", "registration_number", "created_at",
                       "updated_at", "user_id", "address_id", "status")
  end
end
