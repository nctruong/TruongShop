class AdminController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!, :admin_user
end