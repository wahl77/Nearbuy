$('.spinner').hide()
$('#items').replaceWith("<%= j render partial: "items/items", locals:{items: @items} %>")
