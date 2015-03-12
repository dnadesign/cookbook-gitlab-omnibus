module Gitlab
  module Helpers

    def print_config_option(value)
      if value.is_a?(String)
        %Q('#{value}')
      else
        value
      end
    end
  end
end
