class Share::Buffer < Share::Service
  URL = "http://bufferapp.com/add"

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
