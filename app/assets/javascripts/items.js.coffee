# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.get_data = () ->
  checkd = $(".results_category input[type=checkbox]:checked")
  data = ""

  for category in checkd
    data += $(category).val() + ","

  latitude = document.getElementById('address[latitude]').value 
  longitude =  document.getElementById('address[longitude]').value

  options =
    url: "/items/search"
    method: "post"
    data:
      categories: data
      query: $("#query").val()
      range: $("#search_range").val()
      address: 
        latitude: document.getElementById('address[latitude]').value 
        longitude: document.getElementById('address[longitude]').value
    dataType: "script"
    #complete: (response, status) ->
    #  $(".items").empty()
    #  $('.spinner').hide()
    #  document.getElementById('address[latitude]').value = ""
    #  document.getElementById('address[longitude]').value = ""
    #  results = response.responseJSON
    #  for item in results
    #    link = $("<a>").attr("href", "/items/" + item.id).text(item.name)
    #    header = $('<h1>').append(link)
    #    div = $("<div>").attr("class", "item").append(header).append("</h1><p>" + item.description + "</p>")
    #    div.attr("style", "background: url(" + item.image.url.url + "); background-size: 200px 200px; background-size: cover") if item.image != null
    #    $('.items').append(div)

  $.ajax options

jQuery ->
  $(".results_category input[type=checkbox]").on("click", 
    (event) -> 
      $('.spinner').show()
      fill_in_lat_lng(get_data)
  )

jQuery ->
  $("#slider").on("slideStop", 
    () ->
      val = $(".tooltip-inner").text()
      $('#search_range').val(val)
      fill_in_lat_lng(get_data)
      $('.spinner').show()
  )

  $("#slider").slider
    orientation: "horizontal"
    range: "min"
    min: 1
    max: 10
    value: $('#search_range').val()
