class GuesthouseSearchController < ApplicationController
  before_action :redirect_new_host_to_guesthouse_creation

  def quick_search
    @single_query = params[:query]
    @guesthouses = Guesthouse.quick_search(@single_query)

    render 'search_results'
  end

  def advanced_search; end

  def search_results
    search_params = params.require(:guesthouse)
                          .permit(:brand_name, :pet_policy,
                                  address: [:neighbourhood, :city, :state],
                                  room: [:private_bathroom, :balcony,
                                         :air_conditioning, :air_conditioning,
                                         :tv, :closet, :safe, :accessibility])

    @guesthouse_params = search_params.except(:address, :room)
                                      .compact_blank
                                      .delete_if { |_, v| v == '0' }
    @address_params = search_params[:address].compact_blank
    @room_params = search_params[:room].delete_if { |_, v| v == '0' }

    if @guesthouse_params.empty? && @address_params.empty? && @room_params.empty?
      return(redirect_to advanced_search_path,
             alert: 'Informe pelo menos um critério para pesquisa')
    end

    @guesthouses = Guesthouse.advanced_search(@guesthouse_params,
                                              @address_params,
                                              @room_params)
  end
end
