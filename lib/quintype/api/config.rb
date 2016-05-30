module Quintype::API
  class Config < Base(:sketches_host, :sections, :layout, :cdn_name, :publisher_id, :story_slug_format, :cdn_image)
    class << self
      def get
        from_hash(Client.instance.get_config.body)
      end
    end

    coerce_array :sections, Section

    def menu_items
      layout["menu"].map { |i| MenuItem.from_hash(i, self) }
    end

    def stacks
      StackCollection.new layout["stacks"].map { |i| Stack.from_hash(i) }
    end
  end
end
