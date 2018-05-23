require 'rest-client'

class CoolpayController < ApplicationController
  before_action :authenticate, only: [:headers, :list, :add, :list_pay, :make_pay]

  def login
  end

  def list
    get_rest
  end

  def add
    @friend_name = params[:coolpay][:name]
    values = {
      "recipient": {
        "name": "#{@friend_name}"
      }
    }.to_json
    post_rest(values)
    redirect_to list_path
  end

  def list_pay
    list_payments
  end

  def make_pay
    get_rest
    @amount = params[:coolpay][:amount]
    @currency = params[:coolpay][:currency]
    @recipient_id = @recipients.find {|x| x["name"] == params["coolpay"]["name"]}
    values = {
      "payment": {
        "amount": "#{@amount}",
        "currency": "#{@currency}",
        "recipient_id": "#{@recipient_id["id"]}"
      }
    }.to_json
    make_payment(values)
    redirect_to list_pay_path
  end


  private

  def base_url
    'https://coolpay.herokuapp.com/api/'
  end

  def authenticate
    values = {
      "username": ENV["coolpay_user"],
      "apikey": ENV["coolpay_key"]
    }.to_json

    auth_headers = {
      :content_type => 'application/json'
    }
    response = RestClient.post base_url + 'login', values, auth_headers

    @token = JSON.parse(response)["token"]
  end

  def get_rest
    if name_params = params[:coolpay]
      @name = name_params[:name]
      response = RestClient.get base_url + "recipients?name=#{@name.capitalize}", headers
    else
      response = RestClient.get base_url + 'recipients', headers
    end
    @recipients = JSON[response]["recipients"]
  end


  def post_rest(values)
    response = RestClient.post base_url + 'recipients', values, headers
  end

  def list_payments
    payments = RestClient.get base_url + 'payments', headers
    friends = RestClient.get base_url + 'recipients', headers
    @recipients = JSON[friends]["recipients"]
    @payments = JSON[payments]["payments"]
  end

  def make_payment(values)
    response = RestClient.post base_url + 'payments', values, headers
  end


  def headers
    headers = {
      :content_type => 'application/json',
      :authorization => "Bearer #{@token}"
    }
  end

end

