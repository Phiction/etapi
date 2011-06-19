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

	ETAPI.configure do |config|
		config.use_s4      = true
	end

### New

	session = ETAPI::Session.new

Subscribers
-----------

### Add

	tests