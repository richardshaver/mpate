jQuery ->

  $('.results').DataTable()

  setTimeout ( ->
	  $('.flash-notice').slideUp()
  ), 3000

  $('body').on 'click', '.toggle-assignment', (e) ->
  	e.preventDefault()
  	$('#team-assignment').slideDown()
  	$(this).hide()

  .on 'click', '.cancel-assignment', (e) ->
  	e.preventDefault()
  	$('#team-assignment').slideUp ->
  	  	$('.toggle-assignment').show()

