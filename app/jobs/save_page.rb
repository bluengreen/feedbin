class SavePage
  include Sidekiq::Worker
  sidekiq_options queue: :critical

  attr_reader :user, :url

  def perform(user_id, url)
    @user = User.find(user_id)
    @url = url
    entry = create_webpage_entry
    ImageSaver.perform_async(entry.id, entry.url)
    FaviconFetcher.perform_async(host, true)
  end

  def create_webpage_entry
    feed = Feed.create_with(build_feed).find_or_create_by!(feed_url: feed_url)
    user.subscriptions.find_or_create_by!(feed: feed)
    feed.entries.create_with(build_entry).find_or_create_by!(public_id: public_id)
  end

  def feed_url
    hash = Digest::SHA1.hexdigest(user.page_token + user.id.to_s)
    URI::HTTPS.build(
      host: ENV["PAGES_DOMAIN"],
      path: "/#{hash}"
    ).to_s
  end

  def parsed_result
    @parsed_result ||= MercuryParser.parse(url)
  rescue
    nil
  end

  def host
    URI(url).host
  rescue
    url
  end

  def public_id
    Digest::SHA1.hexdigest(feed_url + url)
  end

  def build_feed
    {
      title: "Pages",
      feed_url: feed_url,
      site_url: feed_url,
      protected: true,
      host: ENV["PAGES_DOMAIN"],
      feed_type: :webpage,
    }
  end

  def build_entry
    {
      author: parsed_result&.author,
      content: parsed_result&.content,
      title: parsed_result&.title || host,
      url: url,
      published: parsed_result&.title || Time.now,
      public_id: public_id
    }
  end

end
