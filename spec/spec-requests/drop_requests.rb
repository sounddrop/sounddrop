require 'spec_helper'
require 'rails_helper'
require 'pry'

RSpec.describe "Drop view", :type => :request do

  it "returns 200 if the drop exists" do



    assert_select "form.login" do
      assert_select "input[name=?]", "username"
      assert_select "input[name=?]", "password"
      assert_select "input[type=?]", "submit"
    end

    post "/login", :username => "jdoe", :password => "secret"
    assert_select ".header .username", :text => "jdoe"
  end
end
