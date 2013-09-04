module ProfilesHelper
  def distance_units(short=true)
    if current_user
      case current_user.profile.distance_multiplier
      when 1
        return short ? "km" : "kilometres"
      when 1.60934
        return short ? "mi" : "miles"
      else
        return "error" + current_user.profile.distance_multiplier.to_s
      end
    else
      return short ? "km" : "kilometres"
    end
  end
end
