class AuthController < ApplicationController
  def sign_in

    begin

      conn = Faraday.new(url: 'http://localhost:3000')

      response = conn.post do |req|
        req.url 'http://localhost:3000/api/auth/sign_in'
        req.headers['Authorization'] = Rails.application.credentials.token
        req.body =
        {
          email: params[:email],
          password: params[:password]
        }
      end

      
      json_body = JSON.parse(response.body)

      print(response)

      loged = json_body.key?("data")

      if loged
          
        $uid = response.headers['uid']
        $client = response.headers['client']
        $access_token = response.headers['access-token']

        redirect_to produtos_path

      end

    rescue => exception
      print("erro: ", exception)
    end
    
  end

  def sign_out

    begin

      conn = Faraday.new(url: 'http://localhost:3000')
      
      response = conn.delete do |req|
        req.headers['Authorization'] = Rails.application.credentials.token
        req.url 'http://localhost:3000/api/auth/sign_out'
        req.params['uid'] = $uid
        req.params['client'] = $client
        req.params['access-token'] = $access_token

      end
    
      json_body = JSON.parse(response.body)
      success = json_body['success']

      unless success == false
        redirect_to root_path
      end
    
    rescue => exception
      print("erro: ", exception)
    end

  end

end

