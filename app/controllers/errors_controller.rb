class ErrorsController < ApplicationController
  def error_404
    render :status => 404
  end

  def error_500
  end
end
