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

jQuery ->
  initialize_gmaps_autocomplete()

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
  # End of quick post

  # Get information latitude/longitude from address
  $('form#search_address').on("submit", find_address_location) 
