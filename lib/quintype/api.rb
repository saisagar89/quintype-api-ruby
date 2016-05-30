require "quintype/api/version"

require "faraday"
require "faraday_middleware"
require "hashie"

module Quintype
  module API
    autoload :Client,           "quintype/api/client"
    autoload :BaseFunctions,    "quintype/api/base_functions"

    def self.Base(*args)
      clazz = Struct.new(*args)
      clazz.send(:include, BaseFunctions)
      clazz
    end

    autoload :Config,           "quintype/api/config"
    autoload :Section,          "quintype/api/section"
  end
end
