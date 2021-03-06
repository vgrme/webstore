# frozen_string_literal: true

require_relative "../../../app/models/checkout/delivery_options"

describe DeliveryOptions do
  let(:webstore)         { double("webstore") } # rubocop:disable RSpec/VerifiedDoubles
  let(:customer)         { instance_double(Customer) }
  let(:cart)             { instance_double(Cart, webstore: webstore, customer: customer) }
  let(:args)             { { cart: cart } }
  let(:delivery_options) { described_class.new(args) }

  describe "#existing_delivery_service_id" do
    it "returns a delivery_service id" do
      allow(customer).to receive(:delivery_service_id) { 3 }
      expect(delivery_options.existing_delivery_service_id).to eq(3)
    end
  end

  describe "#can_change_delivery_service?" do
    it "returns true if the there is not an existing delivery service" do
      allow(customer).to receive(:delivery_service_id) { nil }
      expect(delivery_options.can_change_delivery_service?).to be true
    end

    it "returns false if the there is an existing delivery service" do
      allow(customer).to receive(:delivery_service_id) { 3 }
      expect(delivery_options.can_change_delivery_service?).to be false
    end
  end

  describe "#order_frequencies" do
    it "returns a list of order frequency options" do # rubocop:disable RSpec/ExampleLength
      expected_options = [
        ["- Select delivery frequency -", nil],
        ["Deliver weekly on...",          :weekly],
        ["Deliver every 2 weeks on...",   :fortnightly],
        ["Deliver monthly",               :monthly],
        ["Deliver once",                  :single],
      ]

      expect(delivery_options.order_frequencies).to eq(expected_options)
    end
  end

  describe "#extra_frequencies" do
    it "returns a list of extra frequency options" do
      expected_options = [["Include Extra Items with EVERY delivery", false], ["Include Extra Items with NEXT delivery only", true]]
      expect(delivery_options.extra_frequencies).to eq(expected_options)
    end
  end

  describe "#cart_has_extras" do
    it "returns true if this cart allows extras" do
      allow(cart).to receive(:has_extras?) { true }
      expect(delivery_options.cart_has_extras?).to be true
    end
  end

  describe "#to_h" do
    it "returns a hash of the important form data" do # rubocop:disable RSpec/ExampleLength
      start_date = Date.parse("2013-02-03")
      delivery_options.delivery_service = 3
      delivery_options.start_date      = start_date
      delivery_options.frequency       = "single"
      delivery_options.days            = { 1 => 2 }
      delivery_options.extra_frequency = true
      expect(delivery_options.to_h).to eq(delivery_service_id: 3, start_date: start_date, frequency: "single", days: { 1 => 2 }, extra_frequency: true)
    end
  end
end
