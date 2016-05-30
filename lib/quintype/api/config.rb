module Quintype::API
  class Config < Base(:sections)
    class << self
      def get
        from_hash(Client.instance.get_config.body)
      end
    end

    coerce_array :sections, Section
  end
end
