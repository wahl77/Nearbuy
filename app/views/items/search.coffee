$('.spinner').hide()
$('#items').replaceWith("<%= j render partial: "items/items", locals:{items: @items} %>")


$("#map_banner").empty()

jQuery ->
  put_map = () ->
    # Create a custom position object to display map
    position = {
      latitude: "<%= @address.latitude %>"
      longitude: "<%= @address.longitude %>"
    }




    # Finally, display the map
    display_map(position, parseFloat("<%= @range.to_i * 1000 %>"))
  put_map()
