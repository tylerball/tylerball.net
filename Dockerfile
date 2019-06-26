FROM starefossen/ruby-node as middleman

COPY package.json yarn.lock Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN yarn &&\
  bundle install --without=development

COPY . /usr/src/app
RUN bundle exec middleman build --verbose

FROM nginx
COPY --from=middleman /usr/src/app/build /etc/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
