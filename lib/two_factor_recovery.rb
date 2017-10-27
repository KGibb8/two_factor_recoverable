require 'two_factor_recovery/version'
require 'devise'
require 'active_support/concern'
require "active_model"
require "active_record"
require "active_support/core_ext/class/attribute_accessors"
require "cgi"

module TwoFactorRecovery
  autoload :Schema, 'two_factor_recovery/schema'
end

require 'two_factor_recovery/orm/active_record'
require 'two_factor_recovery/routes'
require 'two_factor_recovery/models/two_factor_recoverable'
require 'two_factor_recovery/rails'

module Devise
  mattr_accessor :otp_recovery_code_length
  @@otp_recovery_code_length = 16

  mattr_accessor :otp_number_of_recovery_codes
  @@otp_number_of_recovery_codes = 5
end

Devise.add_module :two_factor_recoverable, model: 'two_factor_recovery/models/two_factor_recoverable', controller: :two_factor_recovery, route: :two_factor_recovery

