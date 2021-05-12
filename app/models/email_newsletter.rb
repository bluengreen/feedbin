class EmailNewsletter

  attr_reader :full_token

  def initialize(email, full_token)
    @email = email
    @full_token = full_token
  end

  def valid?
    true
  end

  def token
    full_token.split("+").first
  end

  def to_email
    @email.to.first
  end

  def from_email
    @email.from.first
  end

  def from_name
    parsed_from.name || from_email
  end

  def name
    parsed_from.name
  end

  def subject
    @email.subject
  end

  def text
    @email.text? ? @email.body.decoded : @email.text_part&.decoded
  end

  def html
    @email.html_part&.decoded
  end

  def content
    html || text
  end

  def timestamp
    @email.date.to_i
  end

  def feed_id
    @feed_id ||= Digest::SHA1.hexdigest("#{full_token}#{from_email}")
  end

  def entry_id
    @entry_id ||= Digest::SHA1.hexdigest("#{feed_id}#{subject}#{timestamp}")
  end

  def domain
    parsed_from.domain
  end

  def feed_url
    "#{site_url}?#{feed_id}"
  end

  def site_url
    @site_url ||= URI::HTTP.build(host: domain).to_s
  end

  def format
    html ? "html" : "text"
  end

  def headers
    {
      "List-Unsubscribe" => @email["List-Unsubscribe"]&.decoded
    }
  end

  private

  def parsed_from
    Mail::Address.new(@email[:from].formatted.first)
  rescue Mail::Field::ParseError
    name, address = @email[:from].formatted.first.split(/[<>]/).map(&:strip)
    domain = address.split("@").last
    OpenStruct.new(name: name, address: address, domain: domain)
  end

end
