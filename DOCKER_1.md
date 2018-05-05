- Install Docker on your local machine. https://docs.docker.com/install/

- Pull image of redis
```
docker pull redis:latest
```

- Pull image of postgres
```
docker pull postgres:latest
```

- Start redis

```
docker run --name my-redis redis
```

- Test the redis server by command

```
redis-cli -h localhost
```

- And it fails :troll:

- Forward port 6379 of container to outside with port 6378

```
docker run --name my-redis -p 6378:6379 redis
```

- Test the redis server by command
```
redis-cli -h localhost -p 6378
```

- And it works

- Bring up postgres
```
docker run \
--name my-postgres \
-p 5433:5432 \
-e POSTGRES_PASSWORD=password \
-e POSTGRES_USER=username \
-e POSTGRES_DB=ehavatar \
postgres

```

- Setup schema again
```
DATABASE_URL=postgres://username:password@localhost:5433/ehavatar \
REDIS_URL=redis://localhost:6378 \
bundle exec ruby setup_schema.rb
```

- Start web server on host machine

```
DATABASE_URL=postgres://username:password@localhost:5433/ehavatar \
REDIS_URL=redis://localhost:6378 \
bundle exec puma
```

- Start sidekiq server on host machine

```
DATABASE_URL=postgres://username:password@localhost:5433/ehavatar \
REDIS_URL=redis://localhost:6378 \
bundle exec bundle exec sidekiq -r ./config/environment.rb
```

- Let’s turn off the postgres docker container and restart

- Oops, all data is gone :’(

- Try again with this command
```
docker run \
--name my-postgres \
-p 5433:5432 \
-e POSTGRES_PASSWORD=password \
-e POSTGRES_USER=username \
-e POSTGRES_DB=ehavatar \
-e PGDATA=/var/data \
-v $(pwd)/tmp/data:/var/data \
postgres
```
