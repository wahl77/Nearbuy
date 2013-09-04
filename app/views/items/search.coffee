$('.spinner').hide()
$('#items').replaceWith("<%= j render partial: "items/items", locals:{items: @items} %>")
jQuery ->
  container = document.querySelector('#items')
  msnry = new Masonry(container,
    itemSelector: ".item"
  )
