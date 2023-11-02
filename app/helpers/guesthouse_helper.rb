module GuesthouseHelper
  def pet_policy_description(guesthouse)
    return 'Aceita pets' if guesthouse.pet_policy
    'Não aceita pets'
  end

  def formatted_checkin_time(guesthouse)
    guesthouse.checkin_time.strftime('%H:%M')
  end

  def formatted_checkout_time(guesthouse)
    guesthouse.checkout_time.strftime('%H:%M')
  end
end
