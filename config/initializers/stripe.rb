Rails.configuration.stripe = {
  :publishable_key => "pk_4oYW06yW6z3hO38KA9fV9dRdLn5za",#ENV['PUBLISHABLE_KEY'],
  :secret_key      => "U2V0vdNRrpqpGaj2qICjXZfMP8ISf2zl"#ENV['SECRET_KEY']
}

Stripe.api_key = "U2V0vdNRrpqpGaj2qICjXZfMP8ISf2zl"#Rails.configuration.stripe[:secret_key]