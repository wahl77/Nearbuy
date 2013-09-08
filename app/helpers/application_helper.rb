module ApplicationHelper

  def distance_calculator(address1, address2)
    return ((address1.distance_to(address2)/distance_multiplier)+0.1).round(1)
  end
end
