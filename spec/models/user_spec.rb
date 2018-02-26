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
  let(:response) { double('Response', :success? => true, :body => json_data.to_json) }

  let(:str_data) do
    "Happy New Year"
  end
  let(:response) { double('Response', :success? => true, :body => str_data.to_s) }


  describe 'pact with provider', :pact => true do

    let(:date) { Time.now.httpdate }

    before do
      new_padrino2.
        given("返回json数据的服务提供者").
          upon_receiving("服务提供者已准备好接收一个获取json数据的http请求").
            with(
                method: :get,
                path: '/provider.json',
                query: URI::encode('valid_date=' + date)
            ).
            will_respond_with(
              status: 200,
              headers: { 'Content-Type' => 'application/json' },
              body: json_data
            )
    end

    it '期望能够从服务提供者处得到处理后的json数据' do
      expect(subject.process_data).to eql([10, Time.parse(json_data['date'])])
    end
  end

  describe 'pact with provider', :pact => true do

    before do
      new_padrino2.
        given("返回string数据的服务提供者").
          upon_receiving("服务提供者已准备好接收一个获取string数据的http请求").
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

    it '期望能够从服务提供者处得到处理后的string数据' do
      expect(subject.process_data2).to eql(str_data)
    end

  end
end
