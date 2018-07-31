FROM starefossen/ruby-node as middleman

COPY package.json yarn.lock Gemfile* /tmp/
WORKDIR /tmp
RUN yarn
RUN bundle install

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app
RUN cp -a /tmp/node_modules /usr/src/app/
RUN bundle exec middleman build --verbose

FROM nginx
COPY --from=middleman /usr/src/app/build /etc/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
