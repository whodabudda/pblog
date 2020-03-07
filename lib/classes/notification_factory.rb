class NotificationFactory
  @@types = ["WEB","EMAIL","SMS"]

  attr_reader :method

  def initialize(method)
    @method = method
  end

  def create_notification
    validate
    case @method
    when "WEB"
      return WebPushNotification
    end
    rescue ArgumentError 
  end

  def validate
   raise StandardError::ArgumentError "#{self.class}.#{__method__.to_s} #{binding.source_location} \n"
                      + "Allowed types #{@@types}"
    if ! @@types.include? @method
  end
end
