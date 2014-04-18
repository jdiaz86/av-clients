require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  setup do
    @client_default = {
	first_name: 'Jorge Alejandro',
	last_name: 'Diaz Echeverria',
	phone_number: '555-3252-2342',
	address: 'NE England Street',
	city: 'Chicago',
	state: 'Illions',
	zip_code: '32420'
   }
 end

 test "should be invalid if missing required data" do
  client = Client.new
  assert !client.valid?
  [:first_name, :last_name, :phone_number].each do |field_name|
     assert client.errors.keys.include? field_name
  end
 end

 test "should be valid if required data exists" do
   client = Client.new(@client_default)
   assert client.valid?
 end


end
