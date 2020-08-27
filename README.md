# Contracts

Ahoy! Welcome to my brand new contracts system! I got really excited developing this with backend in Elixir Phoenix Framework and React frontend. It's functional but not perfect, so here a disclaimer: missing yet some UX improvements and performance updates like Full Text Search with a better technology then `SQL LIKE` or even fix the malformed automatic generated tests. As I am still a begginer in this **great** React world I'm fully open to suggestions that would improve my SPA app in terms of readability and design patterns. Come on, help me as you can!

## Running
In order to run this project locally you'll have to clone the repo with:
```sh
$ git clone git@github.com:abmBispo/Contracts.git
```
If you have docker installed locally you can enter the following to instanciate a database for backend.
```sh
$ docker run --name postgres-database -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres
```
If you do not have docker you can install postgres on your machine and configure `contracs-backend/config/dev.exs` with your database credentials:
```elixir
config :contracts, Contracts.Repo,
  username: DATABASE_USERNAME,
  password: DATABASE_PASSWORD,
  database: DATABASE_NAME,
  hostname: DATABASE_HOST,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```
Now inside `contracs-backend` folder you'll have to run:
```sh
$ mix ecto.create
$ mix ecto.migrate
$ mix phx.server
```
With backend running as it should, you can go to `contracs-frontend` folder and enter the following:
```sh
$ npm i
$ npm start
```

## Dependencies
- **Elixir 1.10.2 (compiled with Erlang/OTP 22)**
- **Postgres 9.6**
- **Node 14.0.0**
- **NPM 6.14.4**
