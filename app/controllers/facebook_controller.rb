class FacebookController < ApplicationController

  def facebook_profile
    @graph = Koala::Facebook::API.new(current_user.oauth_token, Rails.application.secrets.facebook_secret_id)
    @profile = @graph.get_object("me")
    if current_user.email != "471848396509191@facebook.com"
      @friends = @graph.get_connections("me", "friends", api_version: "v2.0")
    else
      @friends = @graph.get_connections("me", "taggable_friends", api_version: "v2.0")
    end
  end
end
