module Quintype::API
  class MenuItem < Base(:id, :item_id, :rank, :title, :item_type, :tag_name, :section_slug, :parent_id, :data)

    def initialize(config, *args)
      @config = config
      super(*args)
    end
  end
end
