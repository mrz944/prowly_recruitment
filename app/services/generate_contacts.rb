# frozen_string_literal: true

class GenerateContacts
  DEFAULT_DOMAIN_PART = '@example.com'

  def initialize(amount = 10000)
    @amount = amount
  end

  def call
    prefix = SecureRandom.alphanumeric(8).downcase

    results = []
    amount.times do |idx|
      name = "#{prefix}_#{idx}"
      results.push(name: name, email: name + DEFAULT_DOMAIN_PART)
    end
    results
  end

  private

  attr_reader :amount
end