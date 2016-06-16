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

  class SearchResults < Base(:from, :size, :total, :stories)
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

  class Story < Base(:updated_at, :assignee_id, :author_name, :tags, :headline, :storyline_id, :votes, :story_content_id, :slug, :last_published_at, :sections, :content_created_at, :owner_name, :custom_slug, :push_notification, :publisher_id, :hero_image_metadata, :comments, :published_at, :storyline_title, :summary, :autotags, :status, :bullet_type, :id, :hero_image_s3_key, :cards, :story_version_id, :content_updated_at, :author_id, :owner_id, :first_published_at, :hero_image_caption, :version, :story_template, :created_at, :authors, :metadata, :publish_at, :assignee_name)

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
