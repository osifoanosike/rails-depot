# Preview all emails at http://localhost:3000/rails/mailers/execption_notifier
class ExecptionNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/execption_notifier/notify_admin
  def notify_admin
    ExecptionNotifier.notify_admin
  end

end
