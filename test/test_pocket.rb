require 'test/unit'
require 'pocket'
require 'json'

class PocketTest < Test::Unit::TestCase




  
  def test_simple_get
    response = Pocket.make_request("http://button.herokuapp.com/")
    
    assert response.code.to_i == 200
    assert_not_nil response.body
    assert response.body.length > 1
  end





  def test_get
    response = Pocket.make_request("http://button.herokuapp.com/stitches")
    
    assert response.code.to_i == 200
    assert_not_nil response.body
    assert response.body.length > 1
  end
  
  
  
  
  
  
  
  def test_post_put_delete
    
    
    # POST
    response = Pocket.make_request("http://button.herokuapp.com/stitches", {
      :method   => :post,
      :data     => {
        :stitch => {
          :thread_color => "blue",
          :length       => 2
        }
      }
    })
    
    assert response.code.to_i == 201
    assert_not_nil response.body
    assert response.body.length > 0
    stitch = JSON.parse(response.body)
    
    
    # PUT
    response = Pocket.make_request("http://button.herokuapp.com/stitches/" + stitch["id"].to_s, {
      :method   => :put,
      :data     => {
        :stitch => {
          :thread_color => "blue",
          :length       => 3
        }
      }
    })
    
    assert response.code.to_i == 200
    assert_not_nil response.body
    assert response.body.length > 0
    stitch = JSON.parse(response.body)
    assert stitch["thread_color"] == "blue"
    assert stitch["length"] == 3
    
    
    # DELETE
    response = Pocket.make_request("http://button.herokuapp.com/stitches/" + stitch["id"].to_s, {
      :method   => :delete,
    })
    
    assert response.code.to_i == 200
     
  end
  
  
  
  
  
  
  
  def test_get_authenticated
    response = Pocket.make_request("http://button.herokuapp.com/needles", {
      :username   => "username",
      :password   => "password"
    })
    assert response.code.to_i == 200
    assert_not_nil response.body
    assert response.body.length > 1
  end
  
  
  
  
  
  
  
  def test_post_put_delete_authenticated
    
    
    # POST
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
    
    assert response.code.to_i == 201
    assert_not_nil response.body
    assert response.body.length > 0
    needle = JSON.parse(response.body)
    
    
    
    # PUT
    response = Pocket.make_request("http://button.herokuapp.com/needles/" + needle["id"].to_s, {
      :method   => :put,
      :data     => {
        :needle => {
          :sharpness    => 5,
          :length       => 3
        }
      },
      :username   => "username",
      :password   => "password"
    })
    
    assert response.code.to_i == 200
    assert_not_nil response.body
    assert response.body.length > 0
    needle = JSON.parse(response.body)
    assert needle["sharpness"] == 5
    assert needle["length"] == 3
    
    
    # DELETE
    response = Pocket.make_request("http://button.herokuapp.com/needles/" + needle["id"].to_s, {
      :method   => :delete,
      :username   => "username",
      :password   => "password"
    })
    
    assert response.code.to_i == 200
     
  end
  

  
end