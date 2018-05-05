- Start postgres with this command, we don't need to expose ports
```
docker run \
--name my-postgres \
-e POSTGRES_PASSWORD=password \
-e POSTGRES_USER=username \
-e POSTGRES_DB=ehavatar \
-e PGDATA=/var/data \
-v $(pwd)/tmp/data:/var/data \
postgres
```

- Start redis with this command, we don't need to expose ports
```
docker run --name my-redis redis
```

- Define a simple dockerfile

```
FROM ruby:2.4.0

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without test

COPY . ./
EXPOSE 9292

CMD ["bundle", "exec", "puma"]
```

- Build docker image with
```
docker build -t ehavatar .
```

- The building process fails.

- We fail to build RMgick gem. Need to add dependencies. Add this line to
  dockerifle

```
RUN apt-get update -qq --fix-missing \
  && apt-get install -y libmagickwand-dev fonts-cantarell lmodern ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts tv-fonts ghostscript
```

- Build again. And it is sure to be successful. Start web server and sidekiq
  server

```
docker run -p 9292:9292 eh-avatar
docker run -p 9292:9292 eh-avatar bundle exec sidekiq -r ./config/environment.rb
```

- And it fails again. We fail to connect to redis and postgres

- Using `link` to link the application containers to dependencies

```
docker run \
--link my-redis \
--link my-postgres \
-e DATABASE_URL=postgres://username:password@my-postgres:5432/ehavatar \
-e REDIS_URL=redis://my-redis:6379 \
-v $(pwd)/tmp:/app/tmp \
-p 9292:9292 \
eh-avatar
```

```
docker run \
--link my-redis \
--link my-postgres \
-e DATABASE_URL=postgres://username:password@my-postgres:5432/ehavatar \
-e REDIS_URL=redis://my-redis:6379 \
-v $(pwd)/tmp:/app/tmp \
eh-avatar bundle exec sidekiq -r ./config/environment.rb
```

- And test again. It should works
