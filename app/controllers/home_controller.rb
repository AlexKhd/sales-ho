class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if User.count.zero? # Add initial data
      load Rails.root.join('db', 'seeds.rb')
    end

    redirect_to new_user_session_path unless current_user
  end
end
