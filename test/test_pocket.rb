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
      :body     => {
        :thread_color => "red",
        :length       => 2
      }
    })
    assert response.code.to_i == 201
    assert_not_nil response.body
    assert response.body.length > 0
    stitch = JSON.parse(response.body)
    
    # PUT
    response = Pocket.make_request("http://button.herokuapp.com/stitches/" + stitch["id"].to_s, {
      :method   => :put,
      :body     => {
        :thread_color => "blue",
        :length       => 3
      }
    })
    assert response.code.to_i == 200
    assert_not_nil response.body
    assert response.body.length > 0
    puts "-->"
    puts response.body
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

  
end