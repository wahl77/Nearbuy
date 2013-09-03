# Make autocomplete of address
window.initialize_gmaps_autocomplete = () ->
  input = document.getElementById('search_location_nav');
  autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.setTypes(['geocode']);

jQuery ->
  initialize_gmaps_autocomplete()

# Diplay a map given a position object (only one position)
window.display_map = (position) ->
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

