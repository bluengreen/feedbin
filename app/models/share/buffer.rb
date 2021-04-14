class Share::Buffer < Share::Service
  URL = "http://bufferapp.com/add"

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
