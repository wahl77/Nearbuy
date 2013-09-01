jQuery ->

  # Make autocomplete of address
  initialize_gmaps_autocomplete = () ->
    input = document.getElementById('search_location_nav');
    autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.setTypes(['geocode']);

    google.maps.event.addListener(autocomplete, 'place_changed', 
      () ->
        place = autocomplete.getPlace();
        document.getElementById('info_bis').value = place.name;
        document.getElementById('cityLat').value = place.geometry.location.lat();
        document.getElementById('cityLng').value = place.geometry.location.lng();
        #//alert("This function is working!");
        #//alert(place.name);
        # alert(place.address_components[0].long_name);
    )



  initialize_gmaps_autocomplete()

