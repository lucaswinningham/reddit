module Worker
  extend ActiveSupport::Concern

  included do
    include Sneakers::Worker
  end

  def work(payload)
    @payload = OpenStruct.new JSON.parse(payload)
    go
    ack!
  end

  private

  attr_reader :payload

  def go; end
end
