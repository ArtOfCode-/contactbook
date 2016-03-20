class AdminController < ApplicationController
  before_filter :authenticate_user
  before_action :verify_admin

  def index
  end
end
