module Quintype::API
  class StoriesRequest
    def initialize(klazz, story_group)
      @klazz = klazz
      @params = {"story-group" => story_group}
    end

    def add_params(params)
      @params.merge!(params)
      self
    end

    def execute!
      from_response(Client.instance.get_stories(@params))
    end

    def from_response(stories)
      stories.map {|i| @klazz.from_hash(i) }
    end

    def to_bulk_request
      @params.merge(_type: "stories")
    end

    def from_bulk_response(response)
      from_response(response["stories"])
    end
  end

  class SearchResults < Base(%w(from size total stories))
    include Enumerable

    def each
      stories.each { |i| yield i }
    end
  end

  class SearchRequest
    def initialize(klazz, params)
      @klazz = klazz
      @params = params
    end

    def execute!
      from_response(Client.instance.get_search(@params))
    end

    def from_response(response)
      mapped_stories = response["stories"].map { |i| @klazz.from_hash(i) }
      SearchResults.from_hash(response.merge("stories" => mapped_stories))
    end
  end

  class Story < Base(%w(updated-at assignee-id author-name tags headline storyline-id votes story-content-id slug last-published-at sections content-created-at owner-name custom-slug push-notification publisher-id hero-image-metadata comments published-at storyline-title summary autotags status bullet-type id hero-image-s3-key cards story-version-id content-updated-at author-id owner-id first-published-at hero-image-caption version story-template created-at authors metadata publish-at assignee-name access))
    class << self
      def find_by_slug(slug)
        response = Client.instance.get_story_by_slug(slug)
        from_hash(response) if response
      end

      def bulk_stories_request(story_group)
        StoriesRequest.new(self, story_group)
      end

      def fetch(story_group, options = {})
        StoriesRequest.new(self, story_group).add_params(options).execute!
      end

      def search(options)
        SearchRequest.new(self, options).execute!
      end
    end
  end
end
