require 'two_factor_recovery/hooks/two_factor_recoverable'

module Devise
  module Models
    module TwoFactorRecoverable
      extend ActiveSupport::Concern

      def self.required_fields(klass)
        [:otp_recovery_codes, :second_factor_recovery_count]
      end

      module ClassMethods
        def has_one_time_recovery_codes
          include InstanceMethodsOnActivation
        end

        ::Devise::Models.config(self, :otp_number_of_recovery_codes, :otp_recovery_code_length)
      end

      module InstanceMethodsOnActivation
        def authenticate_recovery(code, options = {})
          codes = self.otp_recovery_codes || []

          codes.each do |recovery_code|
            next unless Devise::Encryptor.compare(self.class, recovery_code, code)

            codes.delete(recovery_code)
            self.otp_recovery_codes = codes

            return true
          end

          false
        end

        def generate_otp_recovery_codes(options = {})
          codes = []
          number_of_codes = self.class.otp_number_of_recovery_codes
          code_length = self.class.otp_recovery_code_length

          number_of_codes.times do
            codes << SecureRandom.hex(code_length / 2) # Hexstring has length 2*n
          end

          hashed_codes = codes.map { |code| Devise::Encryptor.digest(self.class, code)  }
          self.otp_recovery_codes = hashed_codes

          codes
        end
      end
    end
  end
end
