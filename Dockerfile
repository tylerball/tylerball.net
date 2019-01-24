FROM starefossen/ruby-node as middleman

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json yarn.lock Gemfile* /usr/src/app/
RUN yarn &&\
  bundle install

ADD . /usr/src/app
RUN bundle exec middleman build --verbose

FROM nginx
COPY --from=middleman /usr/src/app/build /etc/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
