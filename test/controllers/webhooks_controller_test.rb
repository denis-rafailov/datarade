require "test_helper"

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "should create subscription on subscription_created event" do
    event_data = file_fixture('subscription_created.json').read

    post webhooks_url, params: event_data, headers: { 'Content-Type' => 'application/json' }

    assert_response :success

    assert Subscription.exists?(stripe_id: "sub_123")
  end

  test "should update subscription on subscription_deleted event" do
    subscription = Subscription.create!(stripe_id: "sub_456", state: "paid")

    event_data = file_fixture('subscription_deleted.json').read

    post webhooks_url, params: event_data, headers: { 'Content-Type' => 'application/json' }

    assert_response :success

    subscription.reload
    assert_equal "canceled", subscription.state
  end
end
