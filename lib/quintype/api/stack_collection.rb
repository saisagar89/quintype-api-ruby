module Quintype::API
  class StackCollection
    include Enumerable

    def initialize(stacks)
      @stacks = stacks
    end

    def each
      @stacks.each { |i| yield i }
    end

    def for_location(location)
      select { |stack| stack.show_on_all_sections? || stack.show_on_locations.include?(location)}
    end
  end
end
