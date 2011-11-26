# Pocket

A curl gem that doesn't suck.

### Installation

In your Gemfile, add this line:

    gem "pocket"
  

### Options & Defaults

Here are the possible options.  Whatever you pass in will merge with and overwrite these defaults.  The :headers options will merge as well, so if you don't want those default headers, you'll
need to pass in a :headers option that overwrites (e.g. 'Content-Type') with nil.

    # defaults
    _options = {
      :method     => :get,
      :username   => nil,
      :password   => nil,
      :use_ssl    => false,
      :data       => nil,
      :headers    => {
        "Content-Type"  => "application/json",
        "Accept"        => "application/json",
      }
    }

### Example Usage

(testing off http://button.herokuapp.com)

Simple get:

    response = Pocket.make_request("http://button.herokuapp.com/stitches")

Simple post:

    response = Pocket.make_request("http://button.herokuapp.com/stitches", {
      :method   => :post,
      :data     => {
        :stitch => {
          :thread_color => "blue",
          :length       => 2
        }
      }
    })

Simple put:

    response = Pocket.make_request("http://button.herokuapp.com/stitches/" + stitch["id"].to_s, {
      :method   => :put,
      :data     => {
        :stitch => {
          :thread_color => "blue",
          :length       => 3
        }
      }
    })


Simple delete:

    response = Pocket.make_request("http://button.herokuapp.com/stitches/" + stitch["id"].to_s, {
      :method   => :delete,
    })

Get with authentication:

    response = Pocket.make_request("http://button.herokuapp.com/needles", {
      :username   => "username",
      :password   => "password"
    })

Post with authentication:

    response = Pocket.make_request("http://button.herokuapp.com/needles", {
      :method   => :post,
      :data     => {
        :needle => {
          :sharpness    => 7,
          :length       => 2
        }
      },
      :username   => "username",
      :password   => "password"
    })

