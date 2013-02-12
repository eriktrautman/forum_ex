require 'spec_helper'

describe "UserPages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "API requests" do

    context "to signin protected pages" do

      context "without valid key" do

        it "should return an errors hash"

      end

      context "with valid key" do



        it "should return the expected JSON object" do
          get(user_path(user),
                  format: :json,
                  params: { :api_key => user.api_key }
                  )
          puts response.body
          response.body.should == user.to_json(:except =>
                                [:api_key, :remember_token ] )
        end

      end

    end

  end
end
