class Share::Twitter < Share::Service
  URL = "https://twitter.com/intent/tweet"

  def initialize(klass = nil)
    @klass = klass
  end

  def share(params); end

  def share_link
    super.merge({
      url: "#{URL}?url=${url}&text=${title}",
      html_options: {"data-behavior" => "share_popup"}
    })
  end
end
