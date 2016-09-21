inet
====

A Postgrex.Extension enabling the use of the inet data type.

Add this module as en extension when establishing your Postgrex connection:

      Postgrex.Connection.start_link(
        database: "inet_test",
        extensions: [{ Inet.Extension, {}}])

Or with Phoenix, open config/{Mix.env}.exs and add the extensions option

      config :myapp, Myapp.Repo,
        adapter: Ecto.Adapters.Postgres,
        extensions: [{Inet, nil}],
        username: "postgres",
        password: "postgres",
        database: "myapp_dev",
        hostname: "localhost",
        pool_size: 10

Then you can do Ecto.Migration like this:

      defmodule MyApp.Repo.Migrations.CreateComputer do
        use Ecto.Migration

        def change do
          create table(:computers) do
            add :ip, :inet
            # other fields
          end
        end
      end

You can also define Ecto.Models using the matching custom Ecto.Type:

      defmodule MyApp.Computer do
        use MyApp.Web, :model

        schema "computers" do
          field :ip, Inet.INET
          # other fields
        end
      end
