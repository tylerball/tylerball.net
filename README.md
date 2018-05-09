tylerball.net
=============

Built with [middleman](https://middlemanapp.com/).

## development

```
docker build -t tylerball.net -f Dockerfile.dev .
docker run -p 4567:4567 tylerball.net bundle exec middleman server
```
