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

    def to_bulk_request
      @params.merge(_type: "stories")
    end

    def from_bulk_response(response)
      response["stories"].map {|i| @klazz.from_hash(i) }
    end
  end

  class Story < Base(:updated_at, :assignee_id, :author_name, :tags, :headline, :storyline_id, :votes, :story_content_id, :slug, :last_published_at, :sections, :content_created_at, :owner_name, :custom_slug, :push_notification, :publisher_id, :hero_image_metadata, :comments, :published_at, :storyline_title, :summary, :autotags, :status, :bullet_type, :id, :hero_image_s3_key, :cards, :story_version_id, :content_updated_at, :author_id, :owner_id, :first_published_at, :hero_image_caption, :version, :story_template, :created_at, :authors, :metadata, :publish_at, :assignee_name)

    class << self
      def find_by_slug(slug)
        response = Client.instance.get_story_by_slug(slug)
        from_hash(response.body["story"]) if response
      end

      def bulk_stories_request(story_group)
        StoriesRequest.new(self, story_group)
      end
    end
  end
end
