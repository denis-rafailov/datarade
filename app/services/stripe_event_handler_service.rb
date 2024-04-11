class StripeEventHandlerService

  def self.handle(json_body)
    event = Stripe::Event.construct_from(json_body)

    case event.type
    when 'customer.subscription.created'
      handle_subscription_creation(event.data.object)
    when 'invoice.paid'
      handle_invoice_paid(event.data.object)
    when 'customer.subscription.deleted'
      handle_subscription_canceled(event.data.object)
    else
      Rails.logger.error "Stripe unable to handle #{event.type} event"
    end
  end

  private

  def self.handle_invoice_paid(invoice)
    subscription = Subscription.find_by(stripe_id: invoice.subscription)
    subscription.update(state: 'paid')
  end

  def self.handle_subscription_canceled(subscription)
    local_subscription = Subscription.find_by(stripe_id: subscription.id)
    local_subscription.update(state: 'canceled') if local_subscription.state == 'paid'
  end

  def self.handle_subscription_creation(subscription)
    Subscription.create(stripe_id: subscription.id, state: 'unpaid')
  end
end
