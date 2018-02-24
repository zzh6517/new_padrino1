require 'spec_helper'
require 'pact_helper'

RSpec.describe User do
    
  let(:json_data) do
    {
      "test" => "NO",
      "date" => "2013-08-16T15:31:20+10:00",
      "count" => 1000
    }
  end
  #let(:response) { double('Response', :success? => true, :body => json_data.to_json) }

    let(:str_data) do
    "string123"
  end
  let(:response) { double('Response', :success? => true, :body => str_data.to_s) }

=begin
  describe 'pact with provider', :pact => true do

    let(:date) { Time.now.httpdate }

    before do
      my_provider.
        given("provider is in a sane state").
          upon_receiving("a request for provider json").
            with(
                method: :get,
                path: '/provider.json',
                query: URI::encode('valid_date=' + date)
            ).
            will_respond_with(
              status: 200,
              headers: { 'Content-Type' => 'application/json;charset=utf-8' },
              body: json_data
            )
    end
=end

  describe 'pact with provider', :pact => true do



    before do
      new_padrino2.
        given("provider is in a sane state").
          upon_receiving("a request for provider string").
            with(
                method: :get,
                path: '/provider.string',
                query: URI::encode('valid_date=' + str_data)
            ).
            will_respond_with(
              status: 200,
              headers: { 'Content-Type' => 'text/html;charset=utf-8' },
              body: str_data
            )
    end

    it 'can process the json payload from the provider' do
      expect(subject.process_data2).to eql(str_data)
    end

  end
end
