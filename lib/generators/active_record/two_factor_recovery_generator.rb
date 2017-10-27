require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class TwoFactorRecoveryGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def copy_two_factor_recovery_migration
        migration_template "two_factor_recovery_migration.rb", "db/migrate/two_factor_recovery_add_to_#{table_name}.rb"
      end
    end
  end
end
