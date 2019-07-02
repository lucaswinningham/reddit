workers = [
  Mailers::User::ActivationWorker
]

sneakers_logger = Rails.env.development? ? STDOUT : 'log/sneakers.log'

Sneakers.configure(amqp: ENV['AMQP_URL'], daemonize: false, log: sneakers_logger)
Sneakers::Runner.new(workers).run
