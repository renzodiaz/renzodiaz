module Dashboard
  class AuthController < ApplicationController
    before_action :authenticate_user!
    layout "dashboard"
  end
end
