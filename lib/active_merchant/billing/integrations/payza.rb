module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Payza
        autoload :Return, 'active_merchant/billing/integrations/payza/return.rb'
        autoload :Helper, 'active_merchant/billing/integrations/payza/helper.rb'
        autoload :Notification, 'active_merchant/billing/integrations/payza/notification.rb'
        
        # Overwrite this if you want to change the Paypal test url
        mattr_accessor :test_url
        self.test_url = 'https://sandbox.payza.com/sandbox/checkout'
        
        # Overwrite this if you want to change the Paypal production url
        mattr_accessor :production_url 
        self.production_url = 'https://secure.payza.com/checkout' 
        
        def self.service_url
          mode = ActiveMerchant::Billing::Base.integration_mode
          case mode
          when :production
            self.production_url    
          when :test
            self.test_url
          else
            raise StandardError, "Integration mode set to an invalid value: #{mode}"
          end
        end
            
        def self.notification(post, options = {})
          Notification.new(post)
        end
        
        def self.return(query_string, options = {})
          Return.new(query_string)
        end
      end
    end
  end
end
