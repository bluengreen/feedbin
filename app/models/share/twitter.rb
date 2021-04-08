class Share::Twitter < Share::Service
  URL = "https://twitter.com/intent/tweet"

  def initialize(klass = nil)
    @klass = klass
  end

  def share(params); end

  def link_options
    action = share(nil)
    defaults = super
    defaults.merge({
      url: "#{URL}?url=${url}&text=${title}",
      html_options: {"data-behavior" => "share_popup"}
    })
  end
end
