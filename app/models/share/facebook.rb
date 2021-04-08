class Share::Facebook < Share::Service
  URL = "https://www.facebook.com/sharer/sharer.php"

  def initialize(klass = nil)
    @klass = klass
  end

  def share(params); end

  def link_options
    action = share(nil)
    defaults = super
    defaults.merge({
      url: "#{URL}?u=${url}&display=popup",
      html_options: {"data-behavior" => "share_popup"}
    })
  end
end
