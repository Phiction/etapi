ExactTarget API Wrapper
=======================

ETAPI is an ExactTarget API wrapper for both XML and SOAP methods.

Installation
------------

```ruby
gem install etapi
```

Configuration
-------------

Create an initializer

```ruby
ETAPI.configure do |config|
	config.username    = "exact_target@username.com"
	config.password    = "password"
	config.api_method  = :soap # (defaults to :xml)
	config.use_s4      = true
end
```

Session
-------

```ruby
session = ETAPI::Session.new(
	:username   => "exact_target@username.com",
	:password   => "password",
	:api_method => :soap,
	:use_s4     => true
)
```

Subscribers
-----------

### Add

```ruby
session.subscriber_add(
	:list_id    => 12345,
	:email      => 'test@test.com',
	:full_name  => 'Test Test',
	:account_id => 1044867 # must include if using s4
)
```

### Delete From List

```ruby
session.subscriber_delete_from_list(
	:list_id    => 12345,
	:email      => 'test@test.com'
)
```

TODO
====

Subscribers
-----------

* Add (:soap)
* Delete (:xml, :soap)
* Delete From List (:xml, :soap)
* Edit (:xml, :soap)
* Master Unsubscribe (:xml, :soap)
* Retrieve (:xml, :soap)

`...and tons of other stuff `