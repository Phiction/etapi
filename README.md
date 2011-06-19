ExactTarget API Wrapper
=======================

ETAPI is an ExactTarget API wrapper for both XML and SOAP methods.

Installation
------------

	gem install etapi

Session
-------

### Configuration

Create an initializer

```ruby
ETAPI.configure do |config|
	# options
end
```

Options (default, available)

* `username`
* `password`
* `api_method` (:xml, [:xml, :soap])
* `use_s4` (false)

### New

	session = ETAPI::Session.new

Subscribers
-----------

### Add

	tests