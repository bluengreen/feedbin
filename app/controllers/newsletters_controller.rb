class NewslettersController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize, only: [:create]

  def create
    newsletter = Newsletter.new(params)
    user = AuthenticationToken.newsletters.active.where(token: newsletter.token).take&.user
    if user && newsletter.valid?
      NewsletterEntry.create(newsletter, user)
    end
    active = user ? !user.suspended : false
    Librato.increment "newsletter.user_active.#{active}"
    head :ok
  end

  def raw
    email = Mail.from_source(request.body.read)
    newsletter = EmailNewsletter.new(email, params[:token])
    user = AuthenticationToken.newsletters.active.where(token: newsletter.token).take&.user
    if user && newsletter.valid?
      NewsletterEntry.create(newsletter, user)
    end
    active = user ? !user.suspended : false
    Librato.increment "newsletter.user_active.#{active}"
    head :ok
  end

  private

  def authorize
    http_basic_authenticate_or_request_with name: "newsletters", password: ENV["NEWSLETTER_PASSWORD"], realm: "Feedbin Newsletters"
  end
end
