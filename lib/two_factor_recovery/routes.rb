module ActionDispatch::Routing
  class Mapper
    protected

    def devise_two_factor_recovery(mapping, controllers)
      resource :two_factor_recovery, only: [:show, :update], path: mapping.path_names[:two_factor_recovery], controller: controllers[:two_factor_recovery]
    end

  end
end
