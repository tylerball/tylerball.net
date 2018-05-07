FROM starefossen/ruby-node as middleman
ADD . /usr/src/app
WORKDIR /usr/src/app
ENV YARN_PRODUCTION=false
RUN yarn
RUN bundle install
RUN bundle exec middleman build --verbose

FROM nginx
COPY --from=middleman /usr/src/app/build /usr/share/nginx/html
COPY nginx/default /etc/nginx/sites-enabled/default
