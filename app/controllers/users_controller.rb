class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    username = params.fetch("username")

    matching_users = User.where({ :username => username })

    @the_user = matching_users.at(0)

    render({ :template => "users/show.html.erb" })
  end

  def show_feed
    username = params.fetch("username")
    matching_user = User.where({ :username => username }).at(0)
    @followings = matching_user.followings
    render({ :template => "users/show_feed.html.erb"})
  end

  def liked
    username = params.fetch("username")
    matching_user = User.where({ :username => username }).at(0)
    @likes = matching_user.likes
    render({ :template => "users/show_liked.html.erb"})
  end

  def discovery
    username = params.fetch("username")
    matching_user = User.where({ :username => username }).at(0)
    @followings = matching_user.followings
    render({ :template => "users/show_discovery.html.erb"})
  end


end