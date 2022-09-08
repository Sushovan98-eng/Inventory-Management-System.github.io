# frozen_string_literal: true

# # This class is for AppInterface Controller
class AppInterfaceController < ApplicationController
  before_action :logged_in_user, only: %i[dashboard admin_panel]
  before_action :admin_user, only: [:admin_panel]

  def index; end

  def admin_panel; end

  def dashboard; end
end
