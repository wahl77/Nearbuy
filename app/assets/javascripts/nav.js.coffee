jQuery ->

  # Make autocomplete of address
  initialize_gmaps_autocomplete = () ->
    input = document.getElementById('search_location_nav');
    autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.setTypes(['geocode']);

  initialize_gmaps_autocomplete()
 
