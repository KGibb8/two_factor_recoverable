module TwoFactorRecovery
  module Schema
    def second_factor_recovery_count
      apply_devise_schema :second_factor_recovery_count, Integer, :default => 0
    end

    def otp_recovery_codes
      apply_devise_schema :otp_recovery_codes, String
    end
  end
end
