class Share::Facebook < Share::Service
  URL = "https://www.facebook.com/sharer/sharer.php"

  def initialize(klass = nil)
    @klass = klass
  end

  def share(params); end

  def share_link
    super.merge({
      url: "#{URL}?u=${url}&display=popup",
      html_options: {"data-behavior" => "share_popup"}
    })
  end
end
