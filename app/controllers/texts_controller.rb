class TextsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def create
		# set up a client to talk to the Twilio REST API
		@client = Twilio::REST::Client.new ENV.fetch('ACCOUNT_SID'), ENV.fetch('AUTH_TOKEN')

		@client.messages.create(
		  from: ENV.fetch('PHONE_NUMBER'),
		  to: text_params[:to],
		  body: text_params[:message]
		)

		render json: true
	end

	def text_params
		params.require('text').permit(:to, :message)
	end
end