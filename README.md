## EhAvatar

An application to generate a beautiful avatar for you <3. To setup, please follow the following steps:

- Install `postgres`
- Install `redis`
- Create a postgres name `ehavatar`
- Run `bundle install`
- If you have any problem with RMagick, please follow [https://github.com/rmagick/rmagick](https://github.com/rmagick/rmagick). If you give up on this, please wait until next section <3
- Run `bundle exec ruby setup_schema.rb`
- Start redis in a terminal with `redis-server`
- Start web server in a terminal with `bundle exec puma`
- Start sidekiq server in a terminal with `bundle exec sidekiq -r ./config/environment.rb`

If you are lucky, your machine already has all dependencies. If something is missing, good luck installing the dependencies.

- Create your first avatar with `curl --data name="Ahihi" http://localhost:9292/avatars` (Please replace your own name here)
- Open the url attached in the response in a web browser. And done <3

