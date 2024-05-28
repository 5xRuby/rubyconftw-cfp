ARG APP_ROOT=/src/app
ARG RUBY_VERSION=2.7.8

FROM ruby:${RUBY_VERSION}-alpine AS base
ARG APP_ROOT

RUN apk add --no-cache build-base imagemagick6-dev imagemagick6 postgresql-dev

RUN mkdir -p ${APP_ROOT}
COPY Gemfile Gemfile.lock ${APP_ROOT}/

WORKDIR ${APP_ROOT}
RUN gem install bundler:2.2.33 \
    && bundle config --local deployment 'true' \
    && bundle config --local frozen 'true' \
    && bundle config --local no-cache 'true' \
    && bundle config --local without 'development test' \
    && bundle install -j "$(getconf _NPROCESSORS_ONLN)" \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.c' -delete \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.h' -delete \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.o' -delete \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.gem' -delete

RUN bundle exec bootsnap precompile --gemfile app/ lib/

FROM ruby:${RUBY_VERSION}-alpine
ARG APP_ROOT

RUN apk add --no-cache curl imagemagick6 tzdata shared-mime-info postgresql-libs imagemagick nodejs

COPY --from=base /usr/local/bundle/config /usr/local/bundle/config
COPY --from=base /usr/local/bundle /usr/local/bundle
COPY --from=base ${APP_ROOT}/vendor/bundle ${APP_ROOT}/vendor/bundle
COPY --from=base ${APP_ROOT}/tmp/cache ${APP_ROOT}/tmp/cache

RUN mkdir -p ${APP_ROOT}

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=yes
ENV APP_ROOT=$APP_ROOT

COPY . ${APP_ROOT}

ARG REVISION
ENV REVISION $REVISION
ENV COMMIT_SHORT_SHA $REVISION
RUN echo "${REVISION}" > ${APP_ROOT}/REVISION

# Apply Execute Permission
RUN adduser -h ${APP_ROOT} -D -s /bin/nologin ruby ruby && \
    chown -R ruby:ruby ${APP_ROOT} && \
    chown -R ruby:ruby ${APP_ROOT}/log && \
    chown -R ruby:ruby ${APP_ROOT}/tmp && \
    chmod -R +r ${APP_ROOT}

USER ruby
WORKDIR ${APP_ROOT}

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

# RUN bundle exec rails assets:precompile

EXPOSE 3000
HEALTHCHECK CMD curl -f http://localhost:3000/status || exit 1
ENTRYPOINT ["bin/openbox"]
CMD ["server"]
