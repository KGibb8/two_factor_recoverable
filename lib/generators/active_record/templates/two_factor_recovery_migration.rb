class TwoFactorRecoveryAddTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    add_column :<%= table_name %>, :second_factor_recovery_count, :integer, default: 0
    add_column :<%= table_name %>, :otp_recovery_codes, :text, array: true
  end
end
