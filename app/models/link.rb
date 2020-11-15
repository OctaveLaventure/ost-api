class Link < ApplicationRecord
    before_validation :generate_slug

    validates_presence_of :url
    validates :url, format: URI::regexp(%w[http https])
    validates_format_of :url, :without => /ø\.st/
    validates_format_of :url, :without => /\/xn--pda\.st\//
    validates_uniqueness_of :slug
    validates_length_of :url, within: 3..255, on: :create, message: "too long"
    validates_length_of :slug, within: 1..255, on: :create, message: "too long"

    def short
        Rails.application.routes.url_helpers.short_url(slug: self.slug)
    end

    def generate_slug
        self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
        true
    end

    def self.shorten(url, slug = '')
        link = Link.where(url: url, slug: slug).first
        return link if link

        link = Link.new(url: url, slug: slug)
        return link if link.save
    end
end
