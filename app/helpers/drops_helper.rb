module DropsHelper
  def show_place_location(place)
    if place.longitude && place.latitude
      "Coordinates : #{place.latitude} / #{place.longitude}"
    end
  end
  def google_map_parameter(place)
    if place.longitude && place.latitude
      "#{place.longitude},#{place.latitude}"
    end
  end
end