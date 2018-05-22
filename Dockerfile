FROM starefossen/ruby-node as middleman
ADD . /usr/src/app
WORKDIR /usr/src/app
ENV YARN_PRODUCTION=false
RUN yarn
RUN npm rebuild node-sass
RUN bundle install
RUN bundle exec middleman build --verbose

FROM nginx as nginx
COPY --from=middleman /usr/src/app/build /etc/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
