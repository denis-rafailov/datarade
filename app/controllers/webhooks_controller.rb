class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    StripeEventHandlerService.handle(params.as_json)

    head :ok
  end
end
