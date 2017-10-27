module TwoFactorRecovery
  module Orm
    module ActiveRecord
      module Schema
        include TwoFactorRecovery::Schema
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, TwoFactorRecovery::Orm::ActiveRecord::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, TwoFactorRecovery::Orm::ActiveRecord::Schema
