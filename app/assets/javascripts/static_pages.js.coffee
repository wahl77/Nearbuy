# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  # Make autocomplete of address
  initialize_gmaps_autocomplete = () ->
    input = document.getElementById('search_location_nav');
    autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.setTypes(['geocode']);
  initialize_gmaps_autocomplete()


  # Find information from address field
  find_address_location = (event) -> 
      $('.spinner').show();
      if document.getElementById('cityLat').value == "" && document.getElementById('search_location_nav').value != ""
        event.preventDefault()
      else
        return

      # Use google Geocode to do so
      address = document.getElementById('search_location_nav').value
        
      geocoder = new google.maps.Geocoder()
      geocoder.geocode({'address': address}, locate_address)

  # The callback from Google geocoder
  locate_address = (results, status) ->
    # Create a custom position object to display map
    #console.log results.length
    latLng = results[0].geometry.location
    position = {
      latitude: latLng.lat()
      longitude: latLng.lng()
    }

    if document.getElementById('map_home_page') != null
      # Finally, display the map
      display_map(position)
      # And get items
      get_items(position)
    else
      console.log "Position Lat Lng"
      document.getElementById('cityLat').value = position.latitude
      document.getElementById('cityLng').value = position.longitude
      $('form#search_address').submit()

  # Used as the callback of HTML5 the invormation in variable geo_position contains all data from 
  # HTML5's geolocation object
  acquire_position = (geo_position) ->
    # Create a custom position object to display map
    position = {
      latitude: geo_position.coords.latitude
      longitude: geo_position.coords.longitude
    }
    # Finally, display the map
    display_map(position)
    # And get items
    get_items(position)
    
  # This error will show if something goes wrong when getting HTML5 Geolocation
  show_error = (error) ->
    alert "Sorry, error occured" + error

  # Diplay a map given a position object
  display_map = (position) ->
    console.log position
    mapOptions = {
      zoom: 13
      zoomControl: false,
      disableDefaultUI: true, 
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById('map_home_page'), mapOptions);
    pos = new google.maps.LatLng(position.latitude, position.longitude);
    infowindow = new google.maps.InfoWindow({
      map: map,
      position: pos,
      content: '<div style="min-width: 150px; min-height: 30px;">Items around me</div>'
    })
    map.setCenter(pos)

  # Get a new item list based on position
  get_items = (position) ->
    options = {
      url: "/items/get_sample" 
      type: "get"
      data: {
        "address[latitude]": position.latitude
        "address[longitude]": position.longitude
      }
      dataType: "json"
      complete: (response, status) ->
        $('.items').empty()
        $('.spinner').hide()
        results = response.responseJSON

        for item in results
          link = $("<a>").attr("href", "items/" + item.id).text(item.name)
          header = $('<h1>').append(link)
          div = $("<div>").attr("class", "item").append(header).append("</h1><p>" + item.description + "</p>")
          div.attr("style", "background: url(" + item.image.url.url + "); background-size: 200px 200px; background-size: cover") if item.image != null
          $('.items').append(div)

    }

    $.ajax(options)

  # Get information from input field
  $('#find_address').on("click", find_address_location)
  $('form#address').on("submit", find_address_location) 
  $('form#search_address').on("submit", find_address_location) 
