tylerball.net
=============

Built with [middleman](https://middlemanapp.com/).

## development

```
docker build -t tylerball.net -f Dockerfile.dev .
docker run -p 4567:4567 -v "$PWD/source/:/usr/src/app/source/" tylerball.net bundle exec middleman server
```
