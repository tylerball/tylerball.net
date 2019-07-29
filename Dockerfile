FROM starefossen/ruby-node

RUN apt-get update && apt-get install -y --no-install-recommends nginx

COPY package.json yarn.lock Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN yarn &&\
  bundle install --without=development

COPY data /usr/src/app/data
COPY lib /usr/src/app/lib
COPY source /usr/src/app/source
COPY config.rb webpack.config.js /usr/src/app/
RUN bundle exec middleman build --verbose

RUN cp -rf /usr/src/app/build/* /usr/share/nginx/html
RUN rm /etc/nginx/sites-enabled/*
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
