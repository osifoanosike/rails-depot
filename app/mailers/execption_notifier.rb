class ExecptionNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.execption_notifier.notify_admin.subject
  #
  def notify_admin(exception)
    @exception = exception

    mail to: "osifo@dealdey.com"
  end
end
