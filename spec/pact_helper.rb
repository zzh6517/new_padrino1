require 'pact/consumer/rspec'

Pact.service_consumer "My Consumer" do
  has_pact_with "My Provider" do
    mock_service :my_provider do
      port 1234
    end
  end
end
