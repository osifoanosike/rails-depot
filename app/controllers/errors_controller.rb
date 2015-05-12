class ErrorsController < ApplicationController
  def notify
    console
    @exception = env["action_dispatch.exception"]
    ExceptionNotifier.notify_admin(@exception).deliver_now
  end

  def show
    render text: request.path 
  end
end
