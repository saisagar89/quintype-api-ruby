module Quintype::API
  class MenuItem < Base(%w(id item-id rank title item-type tag-name section-slug parent-id data))

    def initialize(config, *args)
      @config = config
      super(*args)
    end
  end
end
