# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery_nested_form
#= require_tree .

# require turbolinks 

window.my_app = {}

jQuery ->

  # The following is for input field size of navbar
  $("#search_location_nav").on('focus', 
    (event) ->
      $("#query_nav").removeClass('col-lg-6')
      $("#query_nav").addClass('col-lg-3')
      $("#location_query_nav").removeClass('col-lg-3')
      $("#location_query_nav").addClass('col-lg-6')
  )

  $("#search_location_nav").on('focusout', 
    (event) ->
      $("#query_nav").addClass('col-lg-6')
      $("#query_nav").removeClass('col-lg-3')
      $("#location_query_nav").addClass('col-lg-3')
      $("#location_query_nav").removeClass('col-lg-6')
  )
  # End of changind field size

  # The following is for displaying quick form in posting
  $('#post_item').on("focus", 
    (event) -> 
      $('#spread_post_d').addClass("open")
      $('#item_name').focus()
  )
  $('.close_drop_down').on('click'
    (event) ->
      $('#spread_post_d').removeClass("open")
  )
  $("a#new_address").on("click", 
    (event) -> 
      $("#form_old_address").remove()
      $("#old_address_form").remove()
      $("#new_address_form").show()
      $("#form_new_address").show()
  )
  # End of quick post

  # Get information latitude/longitude from address
  $('form#search_address').on("submit", find_items_address) 


# Will put two values into hidden fields
# Then run the call back 
window.fill_in_lat_lng = (callback) ->
  if document.getElementById('address[latitude]').value == "" && document.getElementById('search_location_nav').value != ""
    # Use google Geocode to do so
    address = document.getElementById('search_location_nav').value
      
    geocoder = new google.maps.Geocoder()
    geocoder.geocode({'address': address}, 
      (results, status) -> 
        if (status != "OK")
          alert 'Sorry, no address found'
        else
          # Create a custom position object to display map
          latLng = results[0].geometry.location
          position = {
            latitude: latLng.lat()
            longitude: latLng.lng()
          }
          document.getElementById('address[latitude]').value = position.latitude
          document.getElementById('address[longitude]').value = position.longitude
        # If there is a callback now is the time to perform it
        if callback and (typeof(callback) == "function")
          callback()
    )
  else
    console.log "No lat/lng for address"
    callback()
  


# Aquire Geolocation at start

# This function is ran if geolocation data is over 1/2 hour old
window.find_user_geolocation = () ->
  if navigator.geolocation
    # Acquire HTML5 value in acquire_position
    navigator.geolocation.getCurrentPosition(acquire_position, show_error)
  else
    # User does not support HTML5 geolocation feature

# Specific functions for goelocation
# Do nothing
show_error = (error) ->

# Get the actual position
acquire_position = (geo_position) ->
  # Create a custom position object to display map
  position = {
    latitude: geo_position.coords.latitude
    longitude: geo_position.coords.longitude
  }
  send_data(position)
  display_map(position)

send_data = (position) ->
  options = {
    url: "/update_geolocation" 
    type: "get"
    data: position = { position }
  }
  $.ajax(options)


# Find information based on address and query
window.find_items_address = (event) -> 
  lat = document.getElementById('address[latitude]').value
  address = document.getElementById('search_location_nav').value 
  query = document.getElementById('query').value 
  
  if (address == "" and query != "") or (lat != "") or (query == "" and address == "")
    # Perform search if values are present
    return 
  else  
    event.preventDefault()
    fill_in_lat_lng(
      () -> 
        # Re-read latitude
        lat = document.getElementById('address[latitude]').value

        # We got a vaule back 
        if lat != ""
          # We can now perform a new submit
          $('form#search_address').submit()
    )
