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



# The rest is code to try make the right template
jQuery -> 
  my_app.map = class Map
    constructor: (canvas) ->
      mapOptions = {
        zoomControl: false,
        disableDefaultUI: true, 
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      @infowindow = new google.maps.InfoWindow()
      @markers = []

      # Create a new map given the id
      @map = new google.maps.Map(document.getElementById(canvas), mapOptions);
      
    add_marker: ( latitude, longitude, info_window ) ->
      # Create a new custom marker object
      marker = {
        latitude: latitude
        longitude: longitude
        infowindow: info_window
      }
      # Append it to a list
      @markers.push(marker)


    display_map: () -> 
      bounds = new google.maps.LatLngBounds()
    
      # Loop through each added marker
      for marker in @markers

        # Create a position for them
        pos = new google.maps.LatLng(marker.latitude, marker.longitude)
    
        # Give them a marker
        gmarker = new google.maps.Marker( { position: pos, map: @map } )

        # Add info window with it
        bindInfoWindow(gmarker, @map, @infowindow, marker.infowindow)

        #extend the bounds to include each marker's position
        bounds.extend(gmarker.position)

      if @markers.length == 1
        @map.setCenter(bounds.getCenter())
        @map.setZoom(13)
      else 
        @map.fitBounds(bounds)


    bindInfoWindow = (marker, map, infoWindow, html) ->
      google.maps.event.addListener marker, "click", ->
        infoWindow.setContent html
        infoWindow.open map, marker 
        
