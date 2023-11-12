module GuesthouseHelper
  def pet_policy_description(pets_allowed)
    return 'Aceita pets' if pets_allowed
    'Não aceita pets'
  end

  def formatted_time(time)
    begin
      return '%H:%M' if time.nil?
      time.strftime('%H:%M')
    rescue
      '00:00'
    end
  end

  def search_result_message(guesthouses)
    found = 'resultado encontrado'
    found = 'resultados encontrados' if guesthouses.size > 1
    "#{guesthouses.size} #{found}"
  end

  def formatted_search_param(key, value)
    formatted_string = "#{t(key)}"
    formatted_string << ": \"#{value}\"" unless value == '1'
    formatted_string
  end
end
