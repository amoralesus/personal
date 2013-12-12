class UiController < ApplicationController
  skip_before_filter :authenticate

  before_filter do
    redirect_to :root if Rails.env.production?
  end

  layout "ui"

  def index
  end
end
