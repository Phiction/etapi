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

### Create
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
* Available methods `:xml`, `:soap`
* The subscriber will be added to the parent account if using s4 and :account_id is blank

```ruby
session.subscriber_add(
	:email      => 'test@test.com',
	:list_id    => 12345, # optional
	:account_id => 1044867 # optional if using s4,
	:attributes => {
		"Full Name" => "Demo User",
		"Custom"    => "Value"
	}
)
=> 1234567890 # returns subscriber_id
```

### Edit
```ruby
session.subscriber_edit(
	:subscriber_id => 12345, # must include if finding by subscriber_id
	:list_id       => 12345, # must include if finding by list_id and email
	:email         => 'test@test.com', # must include if finding by list_id and email
	:account_id    => 1044867, # must include if using s4
	:attributes    => {
		'Email__Address' => 'test1@test.com',
		'First__Name'    => 'Test'
	}
)
```

### Delete
```ruby
session.subscriber_delete(
	:subscriber_id => 12345
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
* Delete [:soap]
* Delete From List [:soap]
* Edit [:soap]
* Master Unsubscribe [:xml, :soap]
* Retrieve (by list_id and subscriber_id) [:xml, :soap]
* Retrieve Lists [:xml, :soap]

Code
----
* Rework XML generation
* Merge subscriber_delete and subscriber_delete_from_list
* Add example with attributes for subscriber_add and subsciber_edit