module Quintype::API
  module BaseFunctions
    module ClassFunctions
      def members_as_string
        @members_as_string ||= members.map(&:to_s)
      end

      def from_hash(hash, *args)
        new *(args + hash.values_at(*members_as_string))
      end

      def coerce_array(key, clazz)
        class_eval <<-EOF
          def #{key.to_s}
            super.map { |i| #{clazz.name}.from_hash(i)}
          end
        EOF
      end

      def coerce_key(key, clazz)
        class_eval <<-EOF
          def #{key.to_s}
            #{clazz.name}.from_hash(i)
          end
        EOF
      end
    end

    def self.included(clazz)
      clazz.extend(ClassFunctions)
      clazz.members_as_string.each do |hypenated_key|
        underscore_key = hypenated_key.gsub(/-/, '_')
        clazz.send(:alias_method, underscore_key, hypenated_key) if underscore_key != hypenated_key
      end
    end
  end
end
