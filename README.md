# Datarade - Coding Challenge

## Description:

Write a simple rails application that receives and processes events from Stripe.

## Acceptance criteria:
1. creating a subscription on stripe.com (via subscription UI) creates a simple subscription record in your database
1. the initial state of the subscription record should be 'unpaid'
1. paying the first invoice of the subscription changes the state of your local subscription record from 'unpaid' to 'paid'
1. canceling a subscription changes the state of your subscription record to “canceled”
1. only subscriptions in the state “paid” can be canceled
1. the rails application should be easy to spin so it can be tested by any developer


## Installation steps
```git clone git@github.com:denis-rafailov/datarade.git```

```cd your-project-directory```

```bundle install```

```bundle exec rails db:create db:migrate```

```EDITOR="nano" rails credentials:edit```

Then set your stripe credential keys:
```
stripe:
    secret_key: your_stripe_secret_key
    publishable_key: your_stripe_publishable_key
```

```bundle exec rails s```

Meanwhile on another terminal run stripe CLI:

```brew install stripe/stripe-cli/stripe```

```stripe login```

Use the stripe CLI to trigger any event like:
```
stripe trigger customer.subscription.created
stripe trigger customer.subscription.deleted
```

## Running tests

```bundle exec rails test```

note: application is using sqlite3 and storing it's data in storage/development.sqlite3
