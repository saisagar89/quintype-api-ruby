module Quintype::API
  class Story < Base(:updated_at, :assignee_id, :author_name, :tags, :headline, :storyline_id, :votes, :story_content_id, :slug, :last_published_at, :sections, :content_created_at, :owner_name, :custom_slug, :push_notification, :publisher_id, :hero_image_metadata, :comments, :published_at, :storyline_title, :summary, :autotags, :status, :bullet_type, :id, :hero_image_s3_key, :cards, :story_version_id, :content_updated_at, :author_id, :owner_id, :first_published_at, :hero_image_caption, :version, :story_template, :created_at, :authors, :metadata, :publish_at, :assignee_name)

    class << self
      def find_by_slug(slug)
        from_hash(Client.instance.get_story_by_slug(slug).body["story"])
      end
    end
  end
end
