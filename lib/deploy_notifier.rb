require 'appscript'

class DeployNotifier
  include Appscript

  def initialize(*names)
    @ichat    = app('iChat')
    @accounts = names.map { |name| bonjour_account(name) }
  end

  def spam(message)
    @accounts.each { |account| send_spam(message, account) }
  end

  private

  def bonjour_account(name)
    @ichat.services['Bonjour'].accounts[name]
  end

  def send_spam(message, account)
    @ichat.send_(message, :to => @account)
  rescue
    $stderr.puts "Error spamming #{account}."
  end
end
