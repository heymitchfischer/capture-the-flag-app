class FlagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @flags = Flag.all
  end
end