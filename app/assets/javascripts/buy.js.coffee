$ ->
  if Stripe
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    subscription.setupForm()

subscription =
  setupForm: ->
    $('#new_subscription').submit ->
      $('input[type=submit]').attr('disabled', true)

      if $('#card_number').length
        subscription.processCard()
        false
      else
        true
  
  processCard: ->
    console.log "Processing card"
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    console.log "Creating token"
    Stripe.createToken(card, subscription.handleStripeResponse)
    
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#subscription_stripe_card_token').val(response.id)
      console.log "Token is #{response.id}"
      $('#new_subscription')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)