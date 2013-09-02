# Make autocomplete of address
window.initialize_gmaps_autocomplete = () ->
  input = document.getElementById('search_location_nav');
  autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.setTypes(['geocode']);

# Diplay a map given a position object (only one position)
window.display_map = (position) ->
  #$('#map_banner').css("display", "block")
  mapOptions = {
    zoom: 13
    zoomControl: false,
    disableDefaultUI: true, 
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById('map_banner'), mapOptions);
  pos = new google.maps.LatLng(position.latitude, position.longitude);
  infowindow = new google.maps.InfoWindow({
    map: map,
    position: pos,
    content: '<div style="min-width: 150px; min-height: 30px;">Items around me</div>'
  })
  map.setCenter(pos)


# This function is ran if geolocation data is over 1/2 hour old
window.find_user_geolocation = () ->
  if navigator.geolocation
    # Acquire HTML5 value in acquire_position
    navigator.geolocation.getCurrentPosition(acquire_position, show_error)
  else
    # User does not support HTML5 geolocation feature












# Specific functions
show_error = (error) ->
  # Do nothing

acquire_position = (geo_position) ->
  # Create a custom position object to display map
  location = {
    latitude: geo_position.coords.latitude
    longitude: geo_position.coords.longitude
  }
  send_data(location)

send_data = (location) ->
  options = {
    url: "/update_geolocation" 
    type: "get"
    data: location = { location }
  }
  $.ajax(options)
