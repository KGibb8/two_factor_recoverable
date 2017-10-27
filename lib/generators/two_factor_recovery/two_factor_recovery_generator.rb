module TwoFactorRecoverable
  module Generators
    class TwoFactorRecoveryGenerator < Rails::Generators::NamedBase
      namespace "two_factor_recovery"

      desc "Adds :two_factor_recoverable directive in the given model. It also generates an active record migration."

      def inject_two_factor_authentication_content
        path = File.join("app", "models", "#{file_path}.rb")
        inject_into_file(path, "two_factor_recoverable, :", :after => "devise :") if File.exists?(path)
      end

      hook_for :orm
    end
  end
end
