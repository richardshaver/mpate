jQuery ->

  $('.results').DataTable()

  setTimeout ( ->
	  $('.flash-notice').slideUp()
  ), 3000