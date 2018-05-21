require 'rest-client'

class CoolpayController < ApplicationController

  def login

  end

  def list
    get_rest
  end

  def add
    @friend_name = params["coolpay"]["Friends Name"]
    values = {
      "recipient": {
        "name": "#{@friend_name}"
      }
    }.to_json
    post_rest(values)
    redirect_to list_path
  end

  private

  def base_url
    'https://coolpay.herokuapp.com/api/'
  end

  def authenticate
    coolpay_user = ENV["coolpay_user"]
    coolpay_key = ENV["coolpay_key"]
    values = {
      "username": coolpay_user,
      "apikey": coolpay_key
    }.to_json

    headers = {
      :content_type => 'application/json'
    }
    response = RestClient.post base_url + 'login', values, headers

    @token = JSON.parse(response)["token"]

    return @token
  end

  def get_rest
    authenticate

    headers = {
      :content_type => 'application/json',
      :authorization => "Bearer #{@token}"
    }
    response = RestClient.get base_url + 'recipients', headers

    @recipients = JSON[response]["recipients"]
  end

  def post_rest(values)
    authenticate
    headers = {
      :content_type => 'application/json',
      :authorization => "Bearer #{@token}"
    }
    response = RestClient.post base_url + 'recipients', values, headers
  end
end

