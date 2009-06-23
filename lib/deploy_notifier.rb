require 'appscript'

class DeployNotifier
  include Appscript

  def initialize(*recipients)
    @application = app('iChat')
    @recipients  = recipients
  end

  def spam(message)
    @recipients.each do |recipient|
      begin
        @application.send_(message, :to => bonjour_account(recipient))
      rescue
        $stderr.puts "Could not spam Bonjour account named #{recipient}."
      end
    end
  end

  private

  def bonjour_account(recipient)
    @application.services['Bonjour'].accounts[recipient]
  end
end
