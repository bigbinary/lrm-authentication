class HomeController < ApplicationController
  def index
    @emails = User.pluck(:email)
  end
end
