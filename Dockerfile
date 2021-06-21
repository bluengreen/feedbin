FROM ruby:2.7

ARG FEEDBIN_URL

ENV RAILS_ROOT /app

RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

RUN echo 'gem: --no-ri --no-rdoc' > ~/.gemrc

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    nodejs \
    libldap-2.4-2 \
    libidn11-dev \
    dnsutils \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/* \
    && gem install idn-ruby -v '0.1.0'

# RUN git clone https://github.com/feedbin/feedbin.git /app

COPY Gemfile $RAILS_ROOT/Gemfile
COPY Gemfile.lock $RAILS_ROOT/Gemfile.lock

RUN gem install bundler -v '2.2.19' \
    && bundle install

COPY . $RAILS_ROOT

RUN bundle exec rake assets:precompile

ENTRYPOINT ["./docker-entrypoint.sh"]
# ENV RAILS_SERVE_STATIC_FILES=true
EXPOSE 3000

CMD ["bin/rails", "s", "-p", "3000", "-b", "0.0.0.0"]
